current_design aes_cipher_top

set clk_name  clk
set clk_port_name clk
set clk_period 5.9 
set clk_port [get_ports $clk_port_name]

create_clock -name $clk_name -period 5.9 $clk_port

set non_clock_inputs [lsearch -inline -all -not -exact [all_inputs] $clk_port]

set_input_delay  [expr $clk_period * 0.2] -clock $clk_name $non_clock_inputs 
set_output_delay [expr $clk_period * 0.2] -clock $clk_name [all_outputs]
