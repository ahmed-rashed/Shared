function [T,f_s,Delta_f]=samplingParameters_D_t_N(Delta_t,N)

f_s=1/Delta_t;
[T,~,Delta_f]=samplingParameters_fs_N(f_s,N);
