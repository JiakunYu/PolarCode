function uplevel = PositionInBlock(IndexInBlock,BlockSize)
    while(IndexInBlock>BlockSize)
        IndexInBlock = IndexInBlock - BlockSize;
    end
    if(IndexInBlock<=BlockSize/2)
        uplevel = 1;
    else
        uplevel = 0;
    end
end