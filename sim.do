set UVM_HOME D:/questasim/verilog_src/uvm-1.1d

set UVM_DPI_HOME D:/questasim/uvm-1.1d/win64

set WORK_HOME C:/Users/win10/Desktop/SRAM

vlib work
vlog  +incdir+$UVM_HOME/src  -timescale 1ns/1ps -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF  $UVM_HOME/src/uvm_pkg.sv  $WORK_HOME/apb_v3_sram.v apb_env_pkg.sv apb_seq_lib_pkg.sv apb_test_pkg.sv tb_top.sv
vsim  -novopt -c -sv_lib $UVM_DPI_HOME/uvm_dpi work.tb_top +UVM_TESTNAME=apb_rand_reg_write_read_test
run -all