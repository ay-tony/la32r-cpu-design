transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ClkPll  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ClkPll xil_defaultlib.glbl

do {ClkPll.udo}

run 1000ns

endsim

quit -force
