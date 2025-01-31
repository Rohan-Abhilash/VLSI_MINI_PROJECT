export PLATFORM         = sky130hd

export DESIGN_NAME      = sha256_unrolled_pipelined

export VERILOG_FILES    = $(sort $(wildcard ./designs/src/$(DESIGN_NAME)/sha256_unrolled_pipelined.v))
export SDC_FILE         = ./designs/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export TNS_END_PERCENT  = 100

export PLACE_DENSITY = 0.2

export DIE_AREA = 0 0 1200 1200

export CORE_AREA = 10 10 1190 1190

#Synthesis Stratergies
export ABC_AREA = 1
