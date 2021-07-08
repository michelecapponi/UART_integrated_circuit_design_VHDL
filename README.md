# UART_integrated_circuit_design_VHDL
This project aimed to develop the hardware design of a device capable of transmitting and receiving data from a serial line implementing the RS232 protocol.
The design was developed by using a hierarchical approach and is composed of four different modules: transmission module, reception module, bus interface, and register files.
Each module, except the register files, is made up to of a Control Unit and an Execution Unit. The control unit (Moore machine) manages the operation of the machine and the Execution Unit runs them.
The synchronization between the modules is managed by a parts Control Unit.
