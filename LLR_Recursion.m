function value = LLR_Recursion(index,level) 
global LLRs
global stage
global bits
    if(LLRs(index,level)~=9999)
        value = LLRs(index,level);
    else
        BlockSize = 2^(stage+1-level);
        if(PositionInBlock(index,BlockSize)) %upperlevel in the block
            L1 = LLR_Recursion(index,level+1);
            L2 = LLR_Recursion(index+BlockSize/2,level+1);
            %value = log((exp(L1+L2)+1)/(exp(L1)+exp(L2)));
            %matlab will have precision problem if the above is used
            %value = sign(L1)*sign(L2)*min([abs(L1),abs(L2)]); %fairly approximate
            value = logdomain_sum(L1+L2,0) - logdomain_sum(L1,L2);
            LLRs(index,level) = value;
            
        else
            upperIndex = index-BlockSize/2;
            L1 = LLR_Recursion(upperIndex,level+1);
            L2 = LLR_Recursion(index,level+1);

            %Calculating the LowerIndex LLRs
            if(bits(upperIndex,level)==0)
                LLRs(index,level) = L1+L2;
            else
                LLRs(index,level) = L2-L1;
            end
            value = LLRs(index,level);
        end

    end
end