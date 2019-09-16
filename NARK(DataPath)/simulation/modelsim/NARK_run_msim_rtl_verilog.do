transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path) {C:/Users/Lenovo/Desktop/NARK (Data path)/TESTBENCH_MODULE.sv}
vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path)/N_BITS_MUX_MODULE {C:/Users/Lenovo/Desktop/NARK (Data path)/N_BITS_MUX_MODULE/ONE_BIT_MUX_MODULE.sv}
vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path)/N_BITS_MUX_MODULE {C:/Users/Lenovo/Desktop/NARK (Data path)/N_BITS_MUX_MODULE/N_BITS_ONE_SELECT_MUX_MODULE.sv}
vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path)/LOGIC_MODULES {C:/Users/Lenovo/Desktop/NARK (Data path)/LOGIC_MODULES/N_BITS_ARITMETIC_SHIFT_RIGHT.sv}
vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path)/LOGIC_MODULES {C:/Users/Lenovo/Desktop/NARK (Data path)/LOGIC_MODULES/_OR.sv}
vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path)/LOGIC_MODULES {C:/Users/Lenovo/Desktop/NARK (Data path)/LOGIC_MODULES/_NOT.sv}
vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path)/LOGIC_MODULES {C:/Users/Lenovo/Desktop/NARK (Data path)/LOGIC_MODULES/_AND.sv}
vlog -sv -work work +incdir+C:/Users/Lenovo/Desktop/NARK\ (Data\ path)/N_BITS_NARK {C:/Users/Lenovo/Desktop/NARK (Data path)/N_BITS_NARK/EXTEND_MODULE.sv}

