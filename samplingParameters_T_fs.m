function [Delta_t,K,Delta_f]=samplingParameters_T_fs(T,f_s)

warning('This function should be avoided since T must be integer multiple of 1/f_s');

Delta_t=1/f_s;
K=T/Delta_t;
if rem(K,1)~=0,error('T must be integer multiple of 1/f_s.'),end
Delta_f=1/T;
