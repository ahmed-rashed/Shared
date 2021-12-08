function [D_t,K,D_f,N_no_fold]=samplingParameters_T_fs(T,f_s)

warning('This function should be avoided since T must be integer multiple of 1/f_s');

D_t=1/f_s;
K=T/D_t;
if rem(K,1)~=0,error('T must be integer multiple of 1/f_s.'),end

[D_f,~,~,N_no_fold]=samplingParameters_fs_N(f_s,K);