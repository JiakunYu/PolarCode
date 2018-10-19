clear;
clc;

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Initialization~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
global N
global K
global R
global stage
global ID
global G
%global LLRs
%global active
%global frozenlookup


stage = 14;
N = 2^stage;
R = 0.5;
K = abs(N*R);
dbscale=0.5;
dbmin=0;
dbmax=7;
BER = zeros(1,(dbmax-dbmin)/dbscale+1);
FER = zeros(1,(dbmax-dbmin)/dbscale+1);
SNR_d=10;

linear_snr_d=10^(SNR_d/10);                %% This is converted from dB value
%e=exp(-R*linear_snr_d);
e=exp(-linear_snr_d);
[C_E_S,ID]=Code_construction(stage,e);      %%C_E_S is the sorted channel probability ID is the sorted channel indices%%
G=Generator_matrix(stage);                  %%G is the generator matrix

flag=0;
frameIndex=0;
for AV_Eb=dbmin:dbscale:dbmax
    
    framesize=0;
    frameIndex=frameIndex+1;
    errors=0;
    frameerror=0;
    while(frameerror<=1000)
        currenterror=error_number(AV_Eb);
        errors=errors+currenterror;
        frameerror=frameerror+(currenterror~=0);
        framesize=framesize+1;
        if(framesize>=800)
            flag=1;
            break;
        end
    end
    BER(frameIndex) = errors/(N*framesize);
    FER(frameIndex) = frameerror/framesize;
    if(flag)
        break;
    end
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Plot the graphs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
AV_Eb=dbmin:dbscale:dbmax;
Plot_result(AV_Eb,BER);