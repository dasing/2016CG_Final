%otsu
%usage:
%       given a histogram and the upper limit(hue_len here), caluclate the
%       theshold of the given histogram using otsu method
%input:

%output:
%       optT: cut level

function optT = thresh_otsu(hist)
%const
S = sum(hist(:));
upLimit = size(hist,2);

%dynamic clculated parameters
maxVb = 0;
optT = 0;

for v =1:upLimit-1
    S0 = sum(hist(1:v));
    Mu0 = weighted_mean(hist,1,v);
    Mu1 = weighted_mean(hist,v+1,upLimit);
    Vb = (S0)*(S-S0)*(Mu0-Mu1)^2;    
    if Vb > maxVb
        maxVb = Vb;
        optT = v;
    end
end

end
