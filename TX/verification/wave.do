onerror {resume}
quietly virtual function -install /testbench/ETICHETTA/label_fsm { 10062.5} virtual_000001
quietly virtual function -install /testbench/ETICHETTA/label_fsm { 10062.5} virtual_000002
quietly virtual function -install /testbench/ETICHETTA/label_fsm { 10062.5} virtual_000003
quietly virtual function -install /testbench/ETICHETTA/label_fsm { 10062.5} virtual_000004
quietly virtual function -install /testbench/ETICHETTA/label_fsm { 10062.5} virtual_000005
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/ETICHETTA/label_datapath/clk
add wave -noupdate /testbench/ETICHETTA/label_datapath/rst_n
add wave -noupdate /testbench/ETICHETTA/label_fsm/reset_n_datapath
add wave -noupdate /testbench/ETICHETTA/label_fsm/enable_tx
add wave -noupdate /testbench/ETICHETTA/label_fsm/load
add wave -noupdate /testbench/ETICHETTA/label_datapath/parallel_load
add wave -noupdate -expand /testbench/ETICHETTA/label_datapath/p_in
add wave -noupdate /testbench/ETICHETTA/label_datapath/sh
add wave -noupdate -color Magenta /testbench/ETICHETTA/label_datapath/TxD
add wave -noupdate /testbench/ETICHETTA/label_datapath/enable_137
add wave -noupdate -color Cyan /testbench/ETICHETTA/label_datapath/enable_9
add wave -noupdate /testbench/ETICHETTA/label_datapath/tc_137
add wave -noupdate /testbench/ETICHETTA/label_datapath/tc_9
add wave -noupdate /testbench/ETICHETTA/label_fsm/TX_EMPTY
add wave -noupdate /testbench/ETICHETTA/label_fsm/en_tx_empty
add wave -noupdate /testbench/ETICHETTA/label_fsm/PRESENT_STATE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9958653 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 285
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {62668800 ps}
