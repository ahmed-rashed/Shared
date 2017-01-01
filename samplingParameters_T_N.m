function [D_t,f_s,D_f]=samplingParameters_T_N(T,N)

D_f=1/T;
D_t=T/N;
f_s=N*D_f;