onerror {exit -code 1}
vlib work
vlog -work work proje.vo
vlog -work work Waveform1.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.proje_vlg_vec_tst -voptargs="+acc"
vcd file -direction proje.msim.vcd
vcd add -internal proje_vlg_vec_tst/*
vcd add -internal proje_vlg_vec_tst/i1/*
run -all
quit -f
