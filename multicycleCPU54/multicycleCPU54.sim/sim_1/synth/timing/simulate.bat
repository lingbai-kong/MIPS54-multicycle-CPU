@echo off
set bin_path=D:\\ModelSim\\win32pe
call %bin_path%/vsim   -do "do {test_post_synthesis_simulate.do}" -l simulate.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
