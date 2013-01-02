
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name FULL_ADDER_SCH -dir "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-02/FULL_ADDER_SCH/planAhead_run_1" -part xc6slx16csg324-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-02/FULL_ADDER_SCH/full_adder_sch.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Documents and Settings/Administrator/Desktop/fpga-lab/cosmiac labs/Lab-02/FULL_ADDER_SCH} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "FULL_ADDER.ucf" [current_fileset -constrset]
add_files [list {FULL_ADDER.ucf}] -fileset [get_property constrset [current_run]]
link_design
