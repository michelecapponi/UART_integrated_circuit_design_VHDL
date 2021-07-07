onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_tb_rx/CLK
add wave -noupdate -color Red /uart_tb_rx/RST_N
add wave -noupdate /uart_tb_rx/CS
add wave -noupdate -color Blue /uart_tb_rx/R_W_N
add wave -noupdate /uart_tb_rx/ATN_ACK
add wave -noupdate /uart_tb_rx/ATN
add wave -noupdate -color Magenta /uart_tb_rx/RXD
add wave -noupdate -color Cyan /uart_tb_rx/TXD
add wave -noupdate /uart_tb_rx/DATA_IN
add wave -noupdate /uart_tb_rx/DATA_OUT
add wave -noupdate /uart_tb_rx/ADDRESS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88475485 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 400
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
WaveRestoreZoom {0 ps} {3637248 ps}
