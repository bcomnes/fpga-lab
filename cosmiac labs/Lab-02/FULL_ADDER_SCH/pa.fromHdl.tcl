
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name FULL_ADDER_SCH -dir "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-02/FULL_ADDER_SCH/planAhead_run_2" -part xc6slx16csg324-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "FULL_ADDER.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {full_adder_sch.vhf}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top full_adder_sch $srcset
add_files [list {FULL_ADDER.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-2
