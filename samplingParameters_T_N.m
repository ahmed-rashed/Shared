function [D_t,f_s,D_f,N_no_fold]=samplingParameters_T_N(T,N)

D_t=T/N;
[~,f_s,D_f,N_no_fold]=samplingParameters_D_t_N(D_t,N);