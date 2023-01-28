

vlog interrupt_delayer_imm.v
vsim interrupt_delayer_imm


add wave *
force -freeze sim:/interrupt_delayer_imm/reset 1 0
run;
force -freeze sim:/interrupt_delayer_imm/reset 0 0

force -freeze sim:/interrupt_delayer_imm/imm 1 0
force -freeze sim:/interrupt_delayer_imm/INTR 1 0


