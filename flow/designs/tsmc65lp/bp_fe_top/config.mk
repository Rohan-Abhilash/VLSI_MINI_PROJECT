export DESIGN_NICKNAME = bp_fe
export DESIGN_NAME = bp_fe_top
export PLATFORM    = tsmc65lp

export SYNTH_HIERARCHICAL = 1

export VERILOG_FILES = $(DESIGN_HOME)/src/$(DESIGN_NAME)/pickled.v \
                       $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/macros.v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export ADDITIONAL_LEFS = $(PLATFORM_DIR)/lef/tsmc65lp_1rf_lg6_w8_bit.lef \
                         $(PLATFORM_DIR)/lef/tsmc65lp_1rf_lg6_w96_bit.lef \
                         $(PLATFORM_DIR)/lef/tsmc65lp_1rf_lg9_w64_bit.lef \
                         $(PLATFORM_DIR)/lef/tsmc65lp_1rf_lg9_w64_all.lef
export ADDITIONAL_LIBS = $(PLATFORM_DIR)/lib/tsmc65lp_1rf_lg6_w8_bit_ss_1p08v_1p08v_125c.lib \
                         $(PLATFORM_DIR)/lib/tsmc65lp_1rf_lg6_w96_bit_ss_1p08v_1p08v_125c.lib \
                         $(PLATFORM_DIR)/lib/tsmc65lp_1rf_lg9_w64_bit_ss_1p08v_1p08v_125c.lib \
                         $(PLATFORM_DIR)/lib/tsmc65lp_1rf_lg9_w64_all_ss_1p08v_1p08v_125c.lib
export ADDITIONAL_GDS  = $(PLATFORM_DIR)/gds/tsmc65lp_1rf_lg6_w8_bit.gds2 \
                         $(PLATFORM_DIR)/gds/tsmc65lp_1rf_lg6_w96_bit.gds2 \
                         $(PLATFORM_DIR)/gds/tsmc65lp_1rf_lg9_w64_bit.gds2 \
                         $(PLATFORM_DIR)/gds/tsmc65lp_1rf_lg9_w64_all.gds2

export DIE_AREA    = 0 0 880 780 
export CORE_AREA   = 10 12 870 770
export PLACE_PINS_ARGS = -exclude left:* -exclude right:0-400 -exclude bottom:*

export MACRO_PLACE_HALO = 10 10
export MACRO_PLACE_CHANNEL = 20 20

export PLACE_DENSITY_LB_ADDON = 0.05
