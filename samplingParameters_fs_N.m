function [T,Delta_t,Delta_f]=samplingParameters_fs_N(f_s,N)

Delta_f=f_s/N;
T=1/Delta_f;
Delta_t=1/f_s;   %also d_t=T/N
