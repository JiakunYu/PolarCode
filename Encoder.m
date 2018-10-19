function [FB,Actual_codeword,Transmitted_bits] = Encoder(N,K,Indices_sorted,Information_bits,C) %%--------FB is the Indices of frozen bits-------%%
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Good_channel_Indices=Indices_sorted(1:K);
FB=Indices_sorted(K+1:end);
Transmitted_bits=zeros(1,N);
Transmitted_bits(Good_channel_Indices)=Information_bits;
codeword=Transmitted_bits*C;
Actual_codeword=mod(codeword,2);
end