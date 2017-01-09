
function [minscore,bound] =calcTypeScore2(hsv,M,hue_len)
    
    [~,W] = size(M);%W = 1 if one space, W=2 if 2 space
    par =[];
    
    for in = 1:W
        parTemp = spaceBound(hue_len,M(2,in),M(1,in));
        par = cat(1,par,parTemp); %2x360 if one sector, 4x360 if 2 sectors
    end
    
    scoreMap = ones(1,size(par,2))*10000;
    for in = 1:size(par,2)
        iterpar = reshape(par(:,in),[2,W]);%reshape to each column a set of low/high par
        scoreMap(in) = spaceScore2(hsv,iterpar,hue_len);
    end

    [minscore,midx] = min(scoreMap);
    bound = reshape(par(:,midx),[2,W]);

    
    
end
