%naive sector cutting
%usage:
%       given the optimal template's bound ,hue iamge and hue_len,
%       calculate the image after remapped to the template.


function O = naiveSectorCut(bound,im_hsv,hue_len,im_h_hist)
    hue_img = im_hsv(:,:,1)*hue_len;
    [~,bW] = size(bound);
    
    if bW<2% only 1 sector case
        %cut = midPoint(bound(1,1),bound(2,1),hue_len);
        %sectorCenter = midPoint(bound(2,1),bound(1,1),hue_len);
        cut = otsu_cut(bound(2,1),bound(1,1),hue_len,im_h_hist);
        sectorCenter = otsu_cut(bound(1,1),bound(2,1),hue_len,im_h_hist);
        
        w= min([abs(sectorCenter - bound(1,1)),abs(sectorCenter - bound(2,1))]);
        %O1 = shiftColor(hue_img,sectorCenter,w,cut,bound(1,1),hue_len,-1);
        %O2 = shiftColor(hue_img,sectorCenter,w,bound(2,1),cut,hue_len,1);
        O1 = shiftColor(hue_img,sectorCenter,w,cut,sectorCenter,hue_len,-1);
        O2 = shiftColor(hue_img,sectorCenter,w,sectorCenter,cut,hue_len,1);
        %Osec1 = containColor(hue_img,bound(1,1),bound(2,1),hue_len);
        O = O1+O2;
        cutset_debug = [cut,sectorCenter];
        hue_circle_hist_debug(im_h_hist,true,bound,true,cutset_debug);
        
    else %2 sectors case
%        cut1 = midPoint(bound(1,1),bound(2,2),hue_len); 
%        cut2 = midPoint(bound(1,2),bound(2,1),hue_len);
%        sectorCenter1 = midPoint(bound(2,1),bound(1,1),hue_len);
%        sectorCenter2 = midPoint(bound(2,2),bound(1,2),hue_len); 
       cut1 = otsu_cut(bound(2,2),bound(1,1),hue_len,im_h_hist);
       cut2 = otsu_cut(bound(2,1),bound(1,2),hue_len,im_h_hist);
       sectorCenter1 =  otsu_cut(bound(1,1),bound(2,1),hue_len,im_h_hist);
       sectorCenter2 =  otsu_cut(bound(1,2),bound(2,2),hue_len,im_h_hist);
       
       w1 = min([abs(sectorCenter1 - bound(1,1)),abs(sectorCenter1 - bound(2,1))]);
       w2 = min([abs(sectorCenter2 - bound(1,2)),abs(sectorCenter2 - bound(2,2))]);
       
       %O11 = shiftColor(hue_img,sectorCenter1,w1,cut1,bound(1,1),hue_len,-1);% 1st sector
       %O21 = shiftColor(hue_img,sectorCenter1,w1,bound(2,1),cut2,hue_len,1);% 1st sector
       %O12 = shiftColor(hue_img,sectorCenter2,w2,cut2,bound(1,2),hue_len,-1);% 2st sector
       %O22 = shiftColor(hue_img,sectorCenter2,w2,bound(2,2),cut1,hue_len,1);% 2st sector
       O11 = shiftColor(hue_img,sectorCenter1,w1,cut1,sectorCenter1,hue_len,-1);% 1st sector
       O21 = shiftColor(hue_img,sectorCenter1,w1,sectorCenter1,cut2,hue_len,1);% 1st sector
       O12 = shiftColor(hue_img,sectorCenter2,w2,cut2,sectorCenter2,hue_len,-1);% 2st sector
       O22 = shiftColor(hue_img,sectorCenter2,w2,sectorCenter2,cut1,hue_len,1);% 2st sector
       %Osec1 = containColor(hue_img,bound(1,1),bound(2,1),hue_len);
       %Osec2 = containColor(hue_img,bound(1,2),bound(2,2),hue_len);
       O = O11 + O21 + O12 + O22 ;
        cutset_debug = [cut1,sectorCenter1,cut2,sectorCenter2];
        hue_circle_hist_debug(im_h_hist,true,bound,true,cutset_debug);
        
    end
    O = O/hue_len;% remap the range of hue from [0,360] to [0,1]
    
end