

vlog interrupt_delayer_imm_controller.v
vsim interrupt_delayer_imm_controller


add wave *
force -freeze sim:/interrupt_delayer_imm_controller/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/interrupt_delayer_imm_controller/rst 1 0

force -freeze sim:/interrupt_delayer_imm_controller/imm 0 0
force -freeze sim:/interrupt_delayer_imm_controller/INTR 0 0
run;
force -freeze sim:/interrupt_delayer_imm_controller/rst 0 0

force -freeze sim:/interrupt_delayer_imm_controller/imm 0 0
force -freeze sim:/interrupt_delayer_imm_controller/INTR 1 0
run;
force -freeze sim:/interrupt_delayer_imm_controller/imm 0 0
force -freeze sim:/interrupt_delayer_imm_controller/INTR 0 0

