function O =containColor(hue_img,low,high,hue_len)
    tempmapL = zeros(size(hue_img));
    tempmapH = zeros(size(hue_img));
    allmap = zeros(size(hue_img));%create a mask to concentrate on only the pixel p whose low<hue(p)<high
    
    tempmapL(hue_img>low) = 1;
    tempmapH(hue_img<high) = 1;
    if low < high
        allmap = tempmapL.* tempmapH;
    else
        allmap = tempmapL + tempmapH;
    end
    
    O = hue_img.*allmap;
    
end