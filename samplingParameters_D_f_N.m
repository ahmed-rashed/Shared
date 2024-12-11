function [T,f_s,D_t,N_no_fold]=samplingParameters_D_f_N(D_f,N)

f_s=D_f*N;
[~,T,D_t,N_no_fold]=samplingParameters_fs_N(f_s,N);