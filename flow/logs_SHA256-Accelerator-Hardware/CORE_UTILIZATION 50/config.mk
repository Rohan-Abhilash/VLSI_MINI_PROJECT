export DESIGN_NICKNAME = SHA256-Accelerator-Hardware
export DESIGN_NAME = sha256_unrolled_pipelined
export PLATFORM    = sky130hd


export VERILOG_FILES = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/sha256_unrolled_pipelined.v \

export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc


export CORE_UTILIZATION=50
export PLACE_DENSITY=0.7

export TNS_END_PERCENT = 100

export RESYNTH_AREA_RECOVER = 1

export REMOVE_ABC_BUFFERS = 1
export TIEHI_CELL_AND_PORT = sky130_fd_sc_hd__conb_1 HI
export TIELO_CELL_AND_PORT = sky130_fd_sc_hd__conb_1 LO
export REMOVE_ABC_BUFFERS = 1
export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 0
export SYNTH_WRAPPED_OPERATORS = 1
export MIN_BUF_CELL_AND_PORTS = 1