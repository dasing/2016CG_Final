% show image hue histogram on the hue wheel
function hue_circle_hist(hist)

    im_wheel = imread('hue_wheel.jpg');
    [wH,wW,~] = size(im_wheel);
    center = [floor(wH/2),floor(wW/2)];
    wheelinR = 76;
    sumHist = max(hist);
    
    for theta = 1:360
        cosT = cosd(theta);
        sinT = -sind(theta);
        histH = floor(wheelinR*hist(theta)/sumHist);
        for wh = wheelinR-histH:wheelinR
            im_wheel(floor(wh*sinT)+center(1),floor(wh*cosT)+center(2),1) = 0;
        end
        
    end
    figure,
    imshow(im_wheel);
end

