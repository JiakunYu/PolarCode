function Bits_Recursion(index,level) 
global bits
global stage

if(level == (stage+1))
    return;
end
BlockSize = 2^(stage+1-level);

if(~PositionInBlock(index,BlockSize)) %lower branch
    UpperIndex = index-BlockSize/2;
    if(bits(UpperIndex,level+1)==9999)
        %calculate the next upper level bit
        bits(UpperIndex,level+1)=mod(bits(UpperIndex,level)+bits(index,level),2);
        Bits_Recursion(UpperIndex,level+1);
    end
    
    if(bits(index,level+1)==9999)
        %calculate the next lower level bit
        bits(index,level+1) = bits(index,level);
        Bits_Recursion(index,level+1);
    end
end
end