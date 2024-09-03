import argparse
import json
import sys


def find_top_module(data):
    # There can be some cruft in the modules list so that
    # we have multiple top level candidates.
    top_module = []
    instantiations = set(
        [
            cell["type"]
            for minfo2 in data["modules"].values()
            for cell in minfo2["cells"].values()
        ]
    )
    for mname, minfo in data["modules"].items():
        if mname not in instantiations:
            top_module.append(mname)
    return top_module


def find_cells_by_type_in_module(
    module_name, data, target_type, current_path, matching_cells
):
    for cell_name, cell in data["modules"][module_name]["cells"].items():
        cell_path = (
            f"{current_path}.{module_name}.{cell_name}"
            if current_path
            else f"{module_name}.{cell_name}"
        )
        if cell["type"] == target_type:
            matching_cells.append(cell_path)
        elif cell["type"] in data["modules"]:
            # Recursively search within the module
            matching_cells.extend(
                find_cells_by_type_in_module(
                    cell["type"], data, target_type, cell_path, []
                )
            )

    return matching_cells


def find_cells_by_type(data, module_name, current_path=""):
    # first find top module, the module without any submodules
    names = []
    for top_module in find_top_module(data):
        names.extend(
            find_cells_by_type_in_module(
                top_module, data, module_name, current_path, []
            )
        )
    return names


def format_ram_table_from_json(data, max_bits=None):
    formatting = "{:>5} | {:>5} | {:>6} | {:<20} | {:<80}\n"
    table = formatting.format("Rows", "Width", "Bits", "Module", "Instances")
    table += "-" * len(table) + "\n"
    max_ok = True
    entries = []

    # Collect the entries in a list
    for module_name, module_info in data["modules"].items():
        cells = module_info["cells"]
        for cell in cells.values():
            if not cell["type"].startswith("$mem"):
                continue
            parameters = cell["parameters"]
            size = int(parameters["SIZE"], 2)
            width = int(parameters["WIDTH"], 2)
            instances = find_cells_by_type(data, module_name)
            bits = size * width * len(instances)
            entries.append((size, width, bits, module_name, ", ".join(instances)))
            if max_bits is not None and bits > max_bits:
                max_ok = False

    # Sort the entries by descending bits
    entries.sort(key=lambda x: x[2], reverse=True)

    # Format the sorted entries into the table
    for entry in entries:
        table += formatting.format(*entry)

    return table, max_ok


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("file")
    parser.add_argument("-m", "--max-bits", type=int, default=None)
    args = parser.parse_args()

    with open(args.file, "r") as file:
        json_data = json.load(file)

    src_files = set()
    for module_name, module_info in json_data["modules"].items():
        for cell in list(module_info["cells"].values()) + [module_info]:
            if "src" not in cell["attributes"]:
                continue
            src_file = cell["attributes"]["src"].split(":")[0]
            src_files.add(src_file)

    print("Source files actually used in the design:")
    print(" " + "\n ".join(src_files))

    print("Memories found in the design:")
    formatted_table, max_ok = format_ram_table_from_json(json_data, args.max_bits)
    print(formatted_table)
    if not max_ok:
        sys.exit(
            "ERROR: Synthesized memory size exceeds maximum allowed bits "
            + str(args.max_bits)
        )
