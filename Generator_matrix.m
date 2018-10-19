function G = Generator_matrix(stage)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
C={};
A1=[1 0;1 1];
C{1}=A1;
for i=2:1:stage
C{i}=kron(C{i-1},A1);
end
G=C{stage};
end

