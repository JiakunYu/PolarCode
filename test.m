
SNR_d=-1.5917;
linear_snr_d=10^(SNR_d/10);                %% This is converted from dB value
e=exp(-linear_snr_d);

initPC(1024,512,'AWGN',-1.5917,1); %last optional argument '1' says "be silent" with no output at the prompt

for AV_Eb=dbmin:dbscale:dbmax
    
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Encoder part~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    normal_snr=10^(AV_Eb/10);                %% This is converted from dB value 
    sigma=sqrt(1/(2*normal_snr));

    for i=1:samplesize
        RS{i}=C_W{i}+sigma*randn(1,2^stage);         %%RS is the signal after the channel combined with the noise%%
    end
    average_num_length = average_num_length + 1;
    for indexindex=1:samplesize
        A=(C_W{indexindex}-1)/(-2);
        y=RS{indexindex}*sqrt(0.5*2*normal_snr);
        uhat = pdecode(y,'AWGN',normal_snr);
        average_num(average_num_length) = average_num(average_num_length)+sum(A==uhat);
    end
    average_num(average_num_length) = average_num(average_num_length)/samplesize;
end

AV_Eb=1:dbscale:dbmax;
Plot_result(AV_Eb,average_num);
legend('Bit error rate Binary');
hold on;