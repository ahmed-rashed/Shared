function [Delta_t,f_s,Delta_f]=samplingParameters_T_N(T,N)

Delta_f=1/T;
Delta_t=T/N;
f_s=N*Delta_f;
