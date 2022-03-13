if {![info exists standalone] || $standalone} {
  # Read lef
  read_lef $::env(TECH_LEF)
  read_lef $::env(SC_LEF)
  if {[info exist ::env(ADDITIONAL_LEFS)]} {
    foreach lef $::env(ADDITIONAL_LEFS) {
      read_lef $lef
    }
  }

  # Read liberty files
  source $::env(SCRIPTS_DIR)/read_liberty.tcl

  # Read design files
  read_def $::env(RESULTS_DIR)/3_1_place_gp_skip_io.def
} else {
  puts "Starting io placement"
}

if {[info exists ::env(IO_CONSTRAINTS)]} {
  source $::env(IO_CONSTRAINTS)
}
place_pins -hor_layer $::env(IO_PLACER_H) \
           -ver_layer $::env(IO_PLACER_V) \
           {*}$::env(PLACE_PINS_ARGS)

if {![info exists save_checkpoint] || $save_checkpoint} {
  write_db $::env(RESULTS_DIR)/3_2_place_iop.odb
}
