# Platform and Design Configuration
export PLATFORM         = sky130hd
export DESIGN_NAME      = sha256_unrolled_pipelined

export VERILOG_FILES = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/sha256_unrolled_pipelined.v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export CORE_UTILIZATION = 45 		#FINAL VALUE

export TNS_END_PERCENT = 100        #FINAL VALUE

export REMOVE_ABC_BUFFERS = 1 		#FINAL VALUE

export RECOVER_POWER=100			#FINAL VALUE

export MATCH_CELL_FOOTPRINT=1       #FINAL VALUE

export RESYNTH_TIMING_RECOVER=1     #FINAL VALUE

export PLACE_DENSITY=0.62			#FINAL VALUE	

export SYNTH_MINIMUM_KEEP_SIZE=1    #FINAL VALUE

export ABC_AREA=0					#FINAL VALUE


export MIN_BUF_CELL_AND_PORTS=0
export USE_FILL=1
