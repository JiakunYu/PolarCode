function Plot_result(AV_Eb,BER) 

semilogy(AV_Eb,BER,'k-*')

xlabel('Eb/No (dB)'); ylabel('BER');
title('Symbol and Bit Error Probability');
legend('Bit error rate Binary');
hold on;

end