function Bits_Recursion(index,level) 
global bits
global stage

if(level == (stage+1))
    return;
end
BlockSize = 2^(stage+1-level);

if(PositionInBlock(index,BlockSize)) %uplevel in the block
%    L1 = LLR_Recursion(index,level+1);
%    LowerIndex = index+BlockSize/2;
%    L2 = LLR_Recursion(LowerIndex,level+1);

    %Calculating the LowerIndex LLRs
%    if(bits(index,level)==0)
%        LLRs(LowerIndex,level) = L1+L2;
%    else
%        LLRs(LowerIndex,level) = L2-L1;
%    end

else            %lowlevel in the block
    
    UpperIndex = index-BlockSize/2;
    if(bits(UpperIndex,level+1)==9999)
        %calculate the next upper level bit
        bits(UpperIndex,level+1)=mod(bits(UpperIndex,level)+bits(index,level),2);
        Bits_Recursion(UpperIndex,level+1);
    %elseif(mod(bits(UpperIndex,level)+bits(index,level),2)~=bits(UpperIndex,level+1))
    %    disp('conflict1');
    end
    
    if(bits(index,level+1)==9999)
        %calculate the next lower level bit
        bits(index,level+1) = bits(index,level);
        Bits_Recursion(index,level+1);
    %elseif(bits(index,level)~=bits(index,level+1))
    %        disp('conflict2');
    end
end
    
end