%midPoint
%usage:
%   given a region, if low<high, calculate the midpoint outside the range,
%   else if low>high calculate the midpoint inside the region. deal with
%   those situation that two bound cross 0 and 360
%input:
%       low:    lower bound
%       high:   upper bound
%       hue_len:usually = 360

function mid = midPoint(low,high,hue_len)
    
    if low<high %calculate the center outside the sector
        half = round(((hue_len-high) + low)/2);
        if (high + half) >hue_len
            mid = low-half;
        else
            mid = high + half;
        end
    else %calculate the center inside the sector
        mid = round((low+high)/2);
    end
end