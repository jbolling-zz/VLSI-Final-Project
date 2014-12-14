********************************************************************
* Carbon Nanotube Field Effect Transistors
*             HSPICE Model
*	       Version 2.2.1
*
*   
*   Copyright The Board Trustees of the Leland Stanford Junior University 2009
*   Albert Lin, Gordon Wan, Jie Deng, Prof. H-S Philip Wong
*   All Rights Reserved.
*
*   09/09/2008 Last Modified by Albert Lin.
*
*   Carbon Nanotube Field Effect Transistors Verilog-A implementation
*   based on 
*   "A Circuit-Compatible SPICE model for Enhancement Mode Carbon 
*   Nanotube Field Effect Transistors" by Jie Deng and H-S Philip Wong 
*
*   Patent Pending.
*   
*   File name: cnfet_sample.sp
********************************************************************

********************************************************************
* LICENSE AGREEMENT
* Stanford Leland Junior University and the authors ("Stanford") 
* provide these model files to you subject to the License Agreement, 
* which may be updated by us from time to time without notice to you. 
* The most-up-to-date License Agreement can be found at
* http://nano.stanford.edu/license.php
********************************************************************


***************************************************
*
*Sample HSPICE Deck
*
***************************************************


.TITLE 'IDS vs VGS for CNFET'


***************************************************
*For optimal accuracy, convergence, and runtime
***************************************************
.options POST
.options AUTOSTOP
.options INGOLD=2     DCON=1
.options GSHUNT=1e-12 RMIN=1e-15 
.options ABSTOL=1e-5  ABSVDC=1e-4 
.options RELTOL=1e-2  RELVDC=1e-2 
.options NUMDGT=4     PIVOT=13

.param   TEMP=27
***************************************************


***************************************************
*Include relevant model files
***************************************************
.lib 'CNFET.lib' CNFET
***************************************************


***************************************************
*Beginning of circuit and device definitions
***************************************************
*Supplies and voltage params:
.param Supply=0.9  	
.param Vg='Supply'
.param Vd='Supply'

*Some CNFET parameters:
.param Ccsd=0      CoupleRatio=0
.param m_cnt=1     Efo=0.6     
.param Wg=0        Cb=40e-12
.param Lg=32e-9    Lgef=100e-9
.param Vfn=0       Vfp=0
.param m=19        n=0        
.param Hox=4e-9    Kox=16 

***********************************************************************
* Define power supply
***********************************************************************
Vdd     Drain     Gnd     Vd
Vss     Source    Gnd     0
Vgg 	  Gate	Gnd	  Vg
Vsub    Sub       Gnd     0

***********************************************************************
* Main Circuits
***********************************************************************
* nFET
XCNT Drain Gate Source Sub NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

* pFET
*XCNT Drain Gate Source Sub PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
*+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

* nFET uniform-tubes model
*XCNT Drain Gate Source Sub NCNFET_uniform Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
*+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n   CNTPos=1 tubes=3

* pFET uniform-tubes model
*XCNT Drain Gate Source Sub PCNFET_uniform Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
*+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n   CNTPOS=0 tubes=3

***********************************************************************
* Measurements
***********************************************************************
* test nFETs, Ids vs. Vgs
.DC      Vgg   START=0     STOP='Supply'   STEP='0.01*Supply' 
+ SWEEP  Vdd   START=0     STOP='Supply'   STEP='0.1*Supply'

* test pFETs, Ids vs. Vgs
*.DC      Vgg   START=0     STOP='-Supply'   STEP='-0.01*Supply' 
*+ SWEEP  Vdd   START=0     STOP='-Supply'   STEP='-0.1*Supply'

***********************************************************************

.print I(Vdd)

.end 




