

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog MCU.v SCU.v rom.v decoder.v Register.v CU.v MCU_test.v

# Open testbench module for simulation

vsim -t 1ns -voptargs="+acc" work.MCU_test

# Add all testbench signals to waveform diagram

add wave /MCU_test/Resetn
add wave /MCU_test/Mclk
add wave /MCU_test/mcu/counter
add wave /MCU_test/mcu/memory/data
add wave /MCU_test/Pclk
add wave /MCU_test/Run
add wave /MCU_test/mcu/Run
add wave /MCU_test/mcu/run_r
add wave /MCU_test/Done
add wave /MCU_test/bus

add wave /MCU_test/mcu/scu/control_unit/current_state
add wave /MCU_test/mcu/scu/control_unit/next_state
add wave /MCU_test/mcu/scu/IR
add wave /MCU_test/mcu/scu/control_unit/IR
add wave /MCU_test/mcu/scu/control_unit/IRin
add wave /MCU_test/mcu/scu//IRin
add wave /MCU_test/mcu/scu/control_unit/command
add wave /MCU_test/mcu/scu/control_unit/reg_control
add wave /MCU_test/mcu/scu/control_unit/mul_control
add wave /MCU_test/mcu/scu/control_unit/DINout
add wave /MCU_test/mcu/scu/mux_control


add wave /MCU_test/mcu/scu/R0/data
add wave /MCU_test/mcu/scu/R1/data
add wave /MCU_test/mcu/scu/R2/data
add wave /MCU_test/mcu/scu/R3/data
add wave /MCU_test/mcu/scu/R4/data
add wave /MCU_test/mcu/scu/R5/data
add wave /MCU_test/mcu/scu/R6/data
add wave /MCU_test/mcu/scu/R7/data
add wave /MCU_test/mcu/scu/A/data
add wave /MCU_test/mcu/scu/alu_w
add wave /MCU_test/mcu/scu/G/data
add wave /MCU_test/mcu/scu/bus_to_alu
add wave /MCU_test/mcu/scu/alu

add wave /MCU_test/mcu/scu/Din
add wave /MCU_test/mcu/scu/R0in
add wave /MCU_test/mcu/scu/R1in
add wave /MCU_test/mcu/scu/R2in
add wave /MCU_test/mcu/scu/R3in
add wave /MCU_test/mcu/scu/R4in
add wave /MCU_test/mcu/scu/R5in
add wave /MCU_test/mcu/scu/R6in
add wave /MCU_test/mcu/scu/R7in
add wave /MCU_test/mcu/scu/Ain
add wave /MCU_test/mcu/scu/Gin

add wave /MCU_test/mcu/scu/R0out
add wave /MCU_test/mcu/scu/R1out
add wave /MCU_test/mcu/scu/R2out
add wave /MCU_test/mcu/scu/R3out
add wave /MCU_test/mcu/scu/R4out
add wave /MCU_test/mcu/scu/R5out
add wave /MCU_test/mcu/scu/R6out
add wave /MCU_test/mcu/scu/R7out
add wave /MCU_test/mcu/scu/Gout
add wave /MCU_test/mcu/scu/DINout


onbreak resume

# Run simulation
run -all

wave zoom full