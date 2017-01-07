%shiftColor
%usage: 
%       shift the pixels in specified hue region(low<H(p)<high) into the corresponding sector 
%input:
%       hue_img     :a 2D mask =  hsv(:,:,1)
%       c           :central position of the sector
%       w           :sector width
%       low         :lower bound of the shiffted region
%       high        :upper bound of the shiffted region
%       hue_len     :useually = 360
%       dirc        : -1 or 1, indicated that the shiffted region should fit to  which direction of the sector
%output:
%       O           :shifted image of the soecified region(pixel out of the region will be set to zero)

function O = shiftColor(hue_img,c,w,low,high,hue_len,dirc)
    
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
    
    
    centerMap = ones(size(hue_img))*c;
    GausExpParMap = -(1/2)*((centerMap-hue_img)./((w/2)*ones(size(hue_img)))).^2;
    GausPar = 1/(w/2*sqrt(2*pi));
    O = centerMap + dirc*(w/2)*(ones(size(hue_img))-GausPar*exp(GausExpParMap));
    O = O.*allmap;
    
    O_too_small = zeros(size(hue_img));
    O_too_small(O<0) = 1;
    O_too_large = zeros(size(hue_img));
    O_too_large(O>hue_len) = 1;
    O_in_range = 1-(O_too_small + O_too_large);
    O = O_in_range.*O + ...
        O_too_small.*(360*ones(size(hue_img)) - O) + ...
        O_too_large.*(O - 360*ones(size(hue_img)));
     
    
end


