

vlog alu.v
vsim alu

add wave *

force -freeze sim:/alu/op 0111 0
force -freeze sim:/alu/rs1 0 0

run;

