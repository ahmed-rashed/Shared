function [NoisySignal,noise]=addNoise(signal,SNR)

noise=std(signal(:))/sqrt(SNR)*randn(size(signal)); %randn produces noise whose std=1
NoisySignal=signal+noise;
