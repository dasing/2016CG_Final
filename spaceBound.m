%spaceBound
%input: hue_len( =360), prozent(..%), start
%output: 2x360 matrix

function O = spaceBound(hue_len, prozent, start)
   
    gap_len = round(hue_len * prozent);
    low = start: hue_len;
    next_secL = 1:start-1;
    low = cat(2,low,next_secL);
    if start+gap_len<=hue_len
        high = start+gap_len: hue_len;
        next_secH = 1:start+gap_len-1;        
    else
        high = (start + gap_len - hue_len): hue_len;
        next_secH = 1:(start + gap_len -hue_len-1);
    end
    high = cat(2,high,next_secH);
    O = [low;high];
   
end
