#!/bin/bash 

# ./run.sh platform design_name variable value1 value2 value3

# Check if at least 4 arguments are provided
if [ $# -lt 4 ]; then
    echo "Usage: $0 <config_file> <logs_dir> <variable> <value1> [value2 ...]"
    echo "Example: $0 ./config.mk ./logs DESIGN_NAME design1 design2"
    exit 1
fi

#Inputs 

PLATFORM="$1"
DESIGN_NAME="$2"
SHUTDOWN_ON_END=1
VARIABLE="$3"
shift 3
PUSH_TO_GIT=0

CONFIG_FILE="./designs/$PLATFORM/$DESIGN_NAME/config.mk"
LOGS_DIR="./logs/$PLATFORM/$DESIGN_NAME/base"
REPORTS_DIR="./reports/$PLATFORM/$DESIGN_NAME/base"
RESULTS_DIR="./results/$PLATFORM/$DESIGN_NAME/base"

# Assign input arguments
#CONFIG_FILE="$1"   # Path to the configuration file
#LOGS_DIR="$2"      # Directory where the flow writes logs
#REPORTS_DIR="$3"   # Directory where the flow stores reports
#RESULTS_DIR="$4"   # Directory where the results odb files are stored
#VARIABLE="$5"      # Variable name to change
#shift 5            # Shift past the first four arguments; remaining are values

# Define the external logs directory
LOGS_SHA256="/mnt/c/Users/Rohan Abhilash/Documents/Python files/Plot Program VLSI Mini Project/logs_$DESIGN_NAME"

# Ensure the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file '$CONFIG_FILE' does not exist"
    exit 1
fi

# Loop through each value provided
for VALUE in "$@"; do
    # Create a subdirectory in logs_sha256 named "variable_name value"
    RESULTS_ROOT_DEST="$LOGS_SHA256/${VARIABLE} ${VALUE}"

    LOG_DEST="$LOGS_SHA256/${VARIABLE} ${VALUE}/logs"
    mkdir -p "$LOG_DEST"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create directory '$LOG_DEST'"
		break
        continue
    fi

    REPORTS_DEST="$LOGS_SHA256/${VARIABLE} ${VALUE}/reports"
    mkdir -p "$REPORTS_DEST"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create directory '$REPORTS_DEST'"
		break
    fi

    RESULTS_DEST="$LOGS_SHA256/${VARIABLE} ${VALUE}/results"
    mkdir -p "$RESULTS_DEST"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create directory '$RESULTS_DEST'"
        break
    fi

    # Check if the variable exists in the config file
    if grep -q "^export\s\+$VARIABLE\s*=" "$CONFIG_FILE"; then
        # Variable exists, update its value
        sed -i "/^export\s\+$VARIABLE\s*=/s|^export\s\+$VARIABLE\s*=\s*.*|export $VARIABLE=$VALUE|" "$CONFIG_FILE"
    else
        # Variable does not exist, add it to the file
        echo "export $VARIABLE=$VALUE" >> "$CONFIG_FILE"
    fi

    # Copy the updated config file to the destination folder
    cp "$CONFIG_FILE" "$RESULTS_ROOT_DEST/"
    if [ $? -ne 0 ]; then
        echo "Warning: Failed to copy config file to '$RESULTS_ROOT_DEST'"
        break
    fi

    # Run the flow
    make "DESIGN_CONFIG=${CONFIG_FILE} clean_all"
    make "DESIGN_CONFIG=${CONFIG_FILE}"
    if [ $? -ne 0 ]; then
        echo "Warning: 'make' failed for $VARIABLE=$VALUE . Stopped flow ."
        break
    fi

    # Copy logs to the destination folder
    if [ -d "$LOGS_DIR" ]; then
        cp -r "$LOGS_DIR"/* "$LOG_DEST/"
        if [ $? -eq 0 ]; then
            echo "Logs successfully copied to '$LOG_DEST'"
        else
            echo "Error: Failed to copy logs to '$LOG_DEST'"
	    	break
        fi
    else
        echo "Warning: Logs directory '$LOGS_DIR' not found. No logs copied."
        break
    fi

    # Copy reports to the destination folder
    if [ -d "$REPORTS_DIR" ]; then
        cp -r "$REPORTS_DIR"/* "$REPORTS_DEST/"
        if [ $? -eq 0 ]; then
            echo "Logs successfully copied to '$REPORTS_DEST'"
        else
            echo "Error: Failed to copy logs to '$REPORTS_DEST'"
	    	break
        fi
    else
        echo "Warning: Logs directory '$REPORTS_DIR' not found. No logs copied."
        break
    fi

    # Copy results to the destination folder
    if [ -d "$RESULTS_DIR" ]; then
        cp -r "$RESULTS_DIR"/* "$RESULTS_DEST/"
        if [ $? -eq 0 ]; then
            echo "Logs successfully copied to '$RESULTS_DEST'"
        else
            echo "Error: Failed to copy logs to '$RESULTS_DEST'"
	    break
        fi
    else
        echo "Warning: Logs directory '$RESULTS_DIR' not found. No logs copied."
        break
    fi
done

if [ "$PUSH_TO_GIT" -eq 1 ]; then
	echo "Pushing to GIT ..."
	./test_git_post.sh "$LOGS_SHA256" "updated_$VARIABLE"
fi


if [ "$SHUTDOWN_ON_END" -eq 1 ]; then
	echo "Shutting Down in 10 seconds ..."
	/mnt/c/Windows/System32/shutdown.exe /s /t 10
else
	echo "All runs completed."
fi
