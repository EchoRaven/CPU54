@echo off
set xv_path=D:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim _246tb_ex10_tb_behav -key {Behavioral:sim_1:Functional:_246tb_ex10_tb} -tclbatch _246tb_ex10_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
