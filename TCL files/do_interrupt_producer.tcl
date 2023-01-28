
vlog interrupt_producer.v
vsim interrupt_producer


add wave *
force -freeze sim:/interrupt_producer/reset 1 0
run;
force -freeze sim:/interrupt_producer/reset 0 0
force -freeze sim:/interrupt_producer/CALL 1 0
run;



