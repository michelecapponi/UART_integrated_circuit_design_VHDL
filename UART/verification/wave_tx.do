onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_tb/CLK
add wave -noupdate /uart_tb/RST_N
add wave -noupdate -color Yellow /uart_tb/CS
add wave -noupdate /uart_tb/R_W_N
add wave -noupdate /uart_tb/ATN_ACK
add wave -noupdate -color Blue /uart_tb/ATN
add wave -noupdate -color Magenta /uart_tb/TXD
add wave -noupdate /uart_tb/RXD
add wave -noupdate /uart_tb/DATA_IN
add wave -noupdate /uart_tb/DATA_OUT
add wave -noupdate /uart_tb/ADDRESS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {314880184 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 297
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {979369984 ps}
