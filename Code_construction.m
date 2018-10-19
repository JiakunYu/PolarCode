function [Last_stage_sorted,Indices_sorted] = Code_construction(stage_number,z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%%clc;
%%clear;

%%error_P=rand(1,100);
Stage=1;
Array=zeros(1,2^Stage-1);
Index=1;
Array_length=1;
Array(1)=z;
p=0;

while(Stage<=stage_number)

    Array(Index+1+p)=2*Array(Index)-Array(Index)^2;
    Array(Index+2+p)=Array(Index)^2;
    Array_length=Array_length+2;
    Index=Index+1;
    p=p+1;
    Stage=floor(log2(Array_length));
end
Acutal_stage=Stage-1;
shift=2.^(Acutal_stage)-1;
Actual_needed=Array(1:Array_length-2);
Last_stage=Actual_needed(length(Actual_needed)-shift:end);
[Last_stage_sorted,Indices_sorted]=sort(Last_stage,'ascend');
%x = linspace(1,2^stage_number,2^stage_number);
%xlim([1 2^stage_number]);
%plot(x,1-Last_stage,'.');
%xlabel('channel index');
%ylabel('channel capacity');
end

