function [bound, maxscore] = calcTypeScore(M,im_hsv_hist)
    [~,hue_len] = size(im_hsv_hist);
    [~,W] = size(M);
    %bound = [];
    maxscore =0;
    Tscore = zeros(1,hue_len);
    
    for in = 1:W
        Tpar = spaceBound(hue_len,M(2,in),M(1,in));
        for t = 1: size(Tpar,2)
            Tscore(t) = Tscore(t) + spaceScore(im_hsv_hist,Tpar(1,t),Tpar(2,t));
        end
    end
    [maxscore,Tidx] = max(Tscore);
    
    Tpar = spaceBound(hue_len,M(2,1),M(1,1));
    bound = [Tidx;Tpar(2,Tidx)];
    if (W>1)
        Tpar = spaceBound(hue_len,M(2,2),M(1,2));
        tempbound = [Tpar(1,Tidx); Tpar(2,Tidx)];
        bound = cat(2, bound, tempbound);
    end
end