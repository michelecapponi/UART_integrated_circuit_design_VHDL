onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/CLK
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/enable_rx
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/PRESENT_STATE
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/RST_N
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/reset_n_datapath
add wave -noupdate -color Magenta /testbench_rx/ETICHETTA/label_fsm_rx/RxD
add wave -noupdate -color Yellow /testbench_rx/ETICHETTA/label_fsm_rx/voter
add wave -noupdate -expand /testbench_rx/ETICHETTA/label_datapath_rx/samples
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/sh_sample
add wave -noupdate -color Blue /testbench_rx/ETICHETTA/label_datapath_rx/dato
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/sh_dato
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/enable_wait
add wave -noupdate -color {Orange Red} /testbench_rx/ETICHETTA/label_fsm_rx/enable_8
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/enable_10
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/enable_16
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/TC_1
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/TC_WAIT
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/TC_8
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/TC_16
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/TC_10
add wave -noupdate -color Cyan /testbench_rx/ETICHETTA/label_fsm_rx/rx_full
add wave -noupdate -color Cyan /testbench_rx/ETICHETTA/label_fsm_rx/err
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/en_rx_full
add wave -noupdate /testbench_rx/ETICHETTA/label_fsm_rx/en_err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6437500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 153
configure wave -valuecolwidth 108
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {4090762 ps} {10384266 ps}
