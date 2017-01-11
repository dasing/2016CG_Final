% show image hue histogram on the hue wheel
function im_wheel = hue_circle_hist_debug(hist,setbound,bound,setcut,cut)

    im_wheel = imread('hue_wheel.jpg');
    [wH,wW,~] = size(im_wheel);
    center = [floor(wH/2),floor(wW/2)];
    wheelinR = 76;
    sumHist = max(hist);
    [~,bW] = size(bound);
    [~,cW] = size(cut);
    
    for theta = 1:360
        cosT = cosd(theta);
        sinT = -sind(theta);
        histH = floor(wheelinR*hist(theta)/sumHist);
        for wh = wheelinR-histH:wheelinR
            im_wheel(floor(wh*sinT)+center(1),floor(wh*cosT)+center(2),1) = 0;
        end
        if(setbound)
            for b = 1:bW
                if(bound(1,b)<bound(2,b))
                    if(theta>=bound(1,b) && theta<=bound(2,b))
                        for wh = 1:wheelinR
                            im_wheel(floor(wh*sinT)+center(1),floor(wh*cosT)+center(2),2) = 0;
                        end
                    end
                else
                    if(theta>=bound(1,b) || theta<=bound(2,b))
                        for wh = 1:wheelinR
                            im_wheel(floor(wh*sinT)+center(1),floor(wh*cosT)+center(2),2) = 0;
                        end
                    end
                end
            end
        end
        if(setcut)
            for c = 1:cW
                if(theta == cut(c))
                     for wh = 1:wheelinR
                         im_wheel(floor(wh*sinT)+center(1),floor(wh*cosT)+center(2),3) = 0;
                     end
                end
            end
        end
    end
%     figure,
%     imshow(im_wheel);
end

