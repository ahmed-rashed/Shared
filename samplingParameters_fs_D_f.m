function [N,T,D_t,N_no_fold]=samplingParameters_fs_D_f(f_s,D_f)

warning('This function should be avoided since f_s must be integer multiple of D_f');
N=f_s/D_f;
if round(N)~=N,error('T must be integer multiple of 1/f_s.'),end

[~,T,D_t,N_no_fold]=samplingParameters_fs_N(f_s,N);