%input:  hsv:    a hsv map
%        bound:  a 2xn metrix, 1st row ist the lower bound and 2nd row is
%                the upper bound.
%        hue_len:360 in default
%output: score:  the corresponding score

function score = spaceScore2(hsv, bound, hue_len)

    [~,bW] = size(bound);
    hmap = hsv(:,:,1)*hue_len;%convert to radian
    smap = hsv(:,:,2);
    tempmapL = zeros(size(hmap));
    tempmapH = zeros(size(hmap));
    allmap = zeros(size(hmap));
    map = ones(size(hmap));%0 within the template 1 otherwise
    
    for in = 1:bW
        tempmapL(hmap>=bound(1,in)) =1;
        tempmapH(hmap<=bound(2,in)) =1;
        if bound(1,in)<bound(2,in)
            allmap = allmap+(tempmapL.*tempmapH);
        else 
            allmap = allmap+(tempmapL+tempmapH);
        end
    tempmapL = zeros(size(hmap));
    tempmapH = zeros(size(hmap));
    end
    map(allmap>0) = 0;
    boundmap = [];
    
    for in = 1:bW
        boundmap = cat(3,boundmap, bound(1,in)*ones(size(hmap))-hmap);
        boundmap = cat(3,boundmap, bound(2,in)*ones(size(hmap))-hmap);
    end
    boundmap = abs(boundmap);
    mapfilter1 = ones(size(boundmap));
    mapfilter1(boundmap>180) =0;
    boundmap = boundmap.*mapfilter1 + (hue_len*ones(size(boundmap))-boundmap).*(1-mapfilter1);
    minmap = min(boundmap,[],3).*map;
    score = sum(sum(minmap.*smap));
       
    
end