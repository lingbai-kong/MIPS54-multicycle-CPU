onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DMEM_opt

do {wave.do}

view wave
view structure
view signals

do {DMEM.udo}

run -all

quit -force
