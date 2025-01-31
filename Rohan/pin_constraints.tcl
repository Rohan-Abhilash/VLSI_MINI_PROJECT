# Get die area dimensions
set die_area [ord::get_die_area]
set xmin [lindex $die_area 0]
set ymin [lindex $die_area 1]
set xmax [lindex $die_area 2]
set ymax [lindex $die_area 3]

# Define margin to keep pins away from corners (adjust as needed)
set margin_x 100  ; # Keep 50 microns away from left/right edges
set margin_y 100 ; # Keep 50 microns away from top/bottom edges
set center_width 500  ; # Width of the center region on each side

# Restrict pin placement to the central part of each side
set_pin_constraints -sides {top}    -regions [list [expr {$xmin + ($xmax - $xmin)/2 - $center_width/2}] $ymax [expr {$xmin + ($xmax - $xmin)/2 + $center_width/2}] $ymax]
set_pin_constraints -sides {bottom} -regions [list [expr {$xmin + ($xmax - $xmin)/2 - $center_width/2}] $ymin [expr {$xmin + ($xmax - $xmin)/2 + $center_width/2}] $ymin]
set_pin_constraints -sides {left}   -regions [list $xmin [expr {$ymin + ($ymax - $ymin)/2 - $center_width/2}] $xmin [expr {$ymin + ($ymax - $ymin)/2 + $center_width/2}]]
set_pin_constraints -sides {right}  -regions [list $xmax [expr {$ymin + ($ymax - $ymin)/2 - $center_width/2}] $xmax [expr {$ymin + ($ymax - $ymin)/2 + $center_width/2}]]

set_pin_length [-hor_length 10] [-ver_length 10]

# Set minimum spacing between pins
set_pin_spacing 10
