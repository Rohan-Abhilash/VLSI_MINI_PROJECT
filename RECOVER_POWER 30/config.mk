# Platform and Design Configuration
export PLATFORM         = sky130hd
export DESIGN_NAME      = sha256_unrolled_pipelined

export VERILOG_FILES = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/sha256_unrolled_pipelined.v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc


export CORE_UTILIZATION = 40
export TNS_END_PERCENT = 100

export REMOVE_ABC_BUFFERS = 1
export RECOVER_POWER=30
