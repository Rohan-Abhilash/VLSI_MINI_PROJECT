# Platform and Design Configuration
export PLATFORM         = sky130hd

export DESIGN_NAME      = sha256_unrolled_pipelined

export VERILOG_FILES    = $(sort $(wildcard ./designs/src/$(DESIGN_NAME)/sha256_unrolled_pipelined.v))

export SDC_FILE         = ./designs/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export CORE_UTILIZATION=25
export TNS_END_PERCENT = 100



export REMOVE_ABC_BUFFERS = 1

