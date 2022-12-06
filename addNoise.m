function [x_hat,n]=addNoise(x_arr,SNR,dim,f_c_by_f_Nyq)
% x_arr can be an array with arbitrary dimension
% dim can be the dimension number or 'all' (default)

if nargin<4
    f_c_by_f_Nyq=1;
else
    if isempty(f_c_by_f_Nyq)
        f_c_by_f_Nyq=1;
    end
end

if nargin<3
    dim='all';
else
    if isempty(dim)
        dim='all';
    end
end

if isnumeric(dim)
    if ~isscalar(dim)
        error('Vector dimension is not supported yet.');
    elseif dim>2
        error('dim is not supported for dimensions higher than 2');
    end
end

if ~isscalar(SNR)
    otherDim=mod(dim+1,2);
    if ~isvector(SNR) || (size(SNR,dim)~=1) || (size(SNR,otherDim)~=size(x_arr,otherDim))
        error('SNR must be a row/column vector that is compatible with x_arr.');
    end

    if ~ismatrix(x_arr),error('For vector SNR, x_arr must be a matrix (2D array).'),end
end

if all(SNR==inf)
    n=zeros(size(x_arr));
    x_hat=x_arr;
else
    n=randn(size(x_arr));
    if f_c_by_f_Nyq~=1
        [b,a]=butter(9,f_c_by_f_Nyq);  %designs a 9th-order low-pass digital Butterworth filter (IIR),where b is a vector containing coefficients of a moving average part and a is a vector containing coefficients of an auto-regressive part of the transfer function (see Equation (6.12) of Shin's book).
        n=filtfilt(b,a,n);  %create a band-limited white noise
    end
    
    if all(SNR==0)   %The signal is replaced with white noise
        n=n/std(n,[],dim);
        x_hat=n;
    else
        n=std(x_arr,[],dim)/std(n,[],dim)./sqrt(SNR).*n;
        x_hat=x_arr+n;
    end
end