function [T,f_s,D_f,N_no_fold]=samplingParameters_D_t_N(D_t,N)

f_s=1/D_t;
[D_f,T,~,N_no_fold]=samplingParameters_fs_N(f_s,N);