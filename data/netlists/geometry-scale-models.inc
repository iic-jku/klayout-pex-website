// Illustrative model, not calibrated PDK data.
load "spice/mos1.osdi"
model nmos sp_mos1 type=1 vto=0.3 kp=50e-6 ld=0.1e-6 tox=10e-9
subckt external (d g s b)
  parameters w=4 l=2 ad=3 as=5 pd=7 ps=11
  m1 (d g s b) nmos w=w l=l ad=ad as=as pd=pd ps=ps
ends
