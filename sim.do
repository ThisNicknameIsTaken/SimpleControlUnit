

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog SPI_master.v SPI_slave.v SPI_Top_level.v

# Open testbench module for simulation

vsim -t 1ns -voptargs="+acc" work.SPI_Top_level

# Add all testbench signals to waveform diagram

add wave /SPI_Top_level/master/rst_n
add wave /SPI_Top_level/master/sys_clk





onbreak resume

# Run simulation
run -all

wave zoom full