function [x_hat,n]=addNoise(x,SNR,f_c_by_f_Nyquist)
% s can be an array with arbitrary size

if nargin<3
    f_c_by_f_Nyquist=1;
else
    if isempty(f_c_by_f_Nyquist)
        f_c_by_f_Nyquist=1;
    end
end

n=randn(size(x));

if f_c_by_f_Nyquist~=1
    [b,a]=butter(9,f_c_by_f_Nyquist);  %designs a 9th-order low-pass digital Butterworth filter (IIR),where b is a vector containing coefficients of a moving average part and a is a vector containing coefficients of an auto-regressive part of the transfer function (see Equation (6.12) of Shin's book).
    n=filtfilt(b,a,n);  %create a band-limited white noise
end

n=std(x(:))/std(n(:))/sqrt(SNR)*n;
x_hat=x+n;
