function errors = error_number(channel_state)
global N
global K
%global R
global stage
global bits
global LLRs
global active
global frozenlookup
global ID
global G
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Encoder part~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        EbN0=10^(channel_state/10);                %% This is converted from dB value 
        sigma=sqrt(1/(2*EbN0));

        I=randi([0 1],1,K);            %%I is the information bits
        [FB,C_W,TS]=Encoder(N,K,ID,I,G);                  %%C_W is the coded N bits word which is 1024 bits in this case%%
        C_W=-2*C_W+1;
        RS=C_W+sigma*randn(1,N);
        %RS=C_W+sigma*sqrt(1/R)*randn(1,N);         %%RS is the signal after the channel combined with the noise%%
        %sqrtEcN0 = sqrt(K/N) * 10^(channel_state/20);
        %y = (2*C_W-1)*sqrtEcN0*sqrt(2) + randn(1,N); %AWGN with normalization

        
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Decoder part~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        active = zeros(N,stage+1);
        bits = ones(N,stage+1)*(9999);
        LLRs = ones(N,stage+1)*(9999);
        frozenlookup = zeros(1,N);
        
        LLRs(:,stage+1) = RS*4*EbN0;
        %LLRs(:,stage+1) = RS*4*EbN0*R; % LLR = ln( Pr(x|0)/Pr(x|1) )
        %EbN0 = 10^(channel_state/10); %dB to linear of SNR:=Eb/N0
        %initialLLRs = - 2 * sqrt(2*(K/N)*EbN0) * y; 
        %LLRs(:,stage+1) = initialLLRs;
        
        frozenlookup(FB)=1;

        for i=0:N-1
            j=bitreversed_order(i,stage)+1;   % To compensate initial array index 1
            LLR_Recursion(j,1);               % Recursively search i_th binary tree for LR

            if(frozenlookup(j))
                bits(j,1)=0;
            else
                if(LLRs(j,1)>=0) 
                    bits(j,1)=0;
                else
                    bits(j,1)=1;
                end
            end
            Bits_Recursion(j,1);              % Bit decision by recursing backwards
        end
        
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Result Comparison~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        A=TS;
        B=bits(:,1)';
        errors = sum(A~=B);
end