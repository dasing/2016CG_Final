function cut = otsu_cut(low,high,hue_len, im_h_hist)
    
if low < high
    cut = low + thresh_otsu(im_h_hist(low:high));
else
    hist = cat(2,im_h_hist(low:hue_len), im_h_hist(1:high));
    cut_temp = low + thresh_otsu(hist);
    if cut_temp<=hue_len
        cut = cut_temp;
    else
        cut = cut_temp-hue_len;
    end
end
       
end