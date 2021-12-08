function [D_f,T,D_t,N_no_fold]=samplingParameters_fs_N(f_s,N)

D_f=f_s/N;
T=1/D_f;
D_t=1/f_s;
N_no_fold=ceil((N+1)/2);