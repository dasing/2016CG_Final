function [ imRecover, im_wheel ] = colorTransfering( bound, im_hsv, hue_len, im_hsv_hist )

%% transfer the color to specific match template
    [ recoverH, im_wheel ] = naiveSectorCut( bound, im_hsv, hue_len,im_hsv_hist);
    
    im_hsv(:,:,1) = recoverH;
    imRecover = hsv2rgb(im_hsv);

end