function [T,f_s,D_f]=samplingParameters_D_t_N(D_t,N)

f_s=1/D_t;
[T,~,D_f]=samplingParameters_fs_N(f_s,N);