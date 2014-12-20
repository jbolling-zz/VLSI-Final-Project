*Final Project
*Joseph Bolling and Akshay Goel
*
*Simulation of a 5 stage cmos oscillator with a CNFET sleep transistor on the 
*ground connection
*
*NETLIST NODES
*vdd: vdd (duh)
*gnd: ground (seriously?)
*o1 ... o5: intermediate connections in ring oscillator
*fgnd: virtual ground node, at drain of sleep transistor
*
 

.lib 'nano_model_39/CNFET.lib' CNFET
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
.param pvdd=0.9V
.param pvsleep=0.9V

*Voltage Sources
vdd vdd gnd pvdd
vsleep nsleep gnd pulse(0v pvsleep 1p 1p 1p 50p 100p)

*CNFET Sleep Transistor
XDevice fgnd nsleep gnd gnd NCNFET tubes=5 

*5 stage CMOS Ring Oscillator
m1 o1 o5 fgnd gnd nmos l=32n w=32n
m2 o1 o5 vdd vdd pmos l=32n w=32n
m3 o2 o1 fgnd gnd nmos l=32n w=32n
m4 o2 o1 vdd vdd pmos l=32n w=32n
m5 o3 o2 fgnd gnd nmos l=32n w=32n
m6 o3 o2 vdd vdd pmos l=32n w=32n
m7 o4 o3 fgnd gnd nmos l=32n w=32n
m8 o4 o3 vdd vdd pmos l=32n w=32n
m9 o5 o4 fgnd gnd nmos l=32n w=32n
m10 o5 o4 vdd vdd pmos l=32n w=32n

*Transient Analysis
.IC v(o1)=pvdd
.tran 0.01p 100p UIC
.end
