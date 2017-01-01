function [D_t,K,D_f]=samplingParameters_T_fs(T,f_s)

D_t=1/f_s;
D_f=1/T;
K=T/D_t;
