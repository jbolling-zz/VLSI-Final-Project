*Final Project
*Single CMOS Simulation (Test for Default Width)
*.lib '../nano_model_39/CNFET.lib' CNFET
.include '32nm_MGK.pm'

.options NOMOD 		POST
.options AUTOSTOP
.options INGOLD=2	DCON=1
.options GSHUNT=1e-12	RMIN=1e-15
.options ABSTOL=1e-5	ABSVDC=1e-4
.options RELTOL=1e-2	RELVDC=1e-2
.options NUMDGT=4	PIVOT=13

*Parameters
.param TEMP=27
.param pvds=1.0V
.param pvgs=1.0V

*Voltage Sources
vdd drain 0 pvds
vin gate 0 pvgs

*Transistor
* m1 drain gate 0 0 nmos l=32n
m2 drain gate 0 0 nmos l=32n w=5u
*****************************************************************
* I tried to make it so it displays m1 and sweeps m2 widths, but
* there's no good way to run two independent simulations in the 
* same netlist. 
*****************************************************************

*DC sweep on gate
.dc vdd 0 pvds 0.01 vin 0.4 pvgs 0.1
.end
