function [T,D_t,D_f]=samplingParameters_fs_N(f_s,N)

D_f=f_s/N;
T=1/D_f;
D_t=1/f_s;   %also d_t=T/N
