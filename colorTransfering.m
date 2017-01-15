function [ imRecover, im_wheel ] = colorTransfering( bound, im_hsv, hue_len, im_hsv_hist, rotateAngle )

%% transfer the color to specific match template
    [ recoverH, im_wheel ] = naiveSectorCut( bound, im_hsv, hue_len,im_hsv_hist, rotateAngle );
    
    im_hsv(:,:,1) = recoverH;
    imRecover = hsv2rgb(im_hsv);
    
    %     %convert to hsv and show histogram
%     disp(O_tmp);
     
%      [H,W] = size(recoverH);
%      im_hsv_hist = zeros(1,361);
%      for h = 1:H
%          for w = 1:W            
%              im_hsv_hist(round(recoverH(h,w))+1) = im_hsv_hist(round(recoverH(h,w))+1) + 1;
%          end
%      end
%      im_hsv_hist = im_hsv_hist(1,1:360);
     %imwrite( imRecover, 'result.png', 'png' );
     %hue_circle_hist(im_hsv_hist, true,bound );
    
end