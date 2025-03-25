# Platform and Design Configuration
export PLATFORM         = sky130hd
export DESIGN_NAME      = sha256_unrolled_pipelined

export VERILOG_FILES = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/sha256_unrolled_pipelined.v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc


export CORE_UTILIZATION = 40
export TNS_END_PERCENT = 100

export REMOVE_ABC_BUFFERS = 1
export RECOVER_POWER=100
export SYNTH_HIERARCHICAL=1
export MATCH_CELL_FOOTPRINT=1
export RESYNTH_TIMING_RECOVER=1
export PLACE_DENSITY=0.5
