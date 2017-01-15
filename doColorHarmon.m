function [imRecover, im_wheel, allBound, ori_im_hsv, hue_len, im_hsv_hist, idx ] = doColorHarmon(imagePath )

    %% read image, remap hue imformation into histogram
    im = imread(imagePath);
    [H,W,~] = size(im);
    im_hsv = rgb2hsv(im);
    im_h = floor(360 * im_hsv(:,:,1));
    m = max(max(im_h));
    %imshow((im_h));

    ori_im_hsv = im_hsv;
    
    %show pure hue image
    im_hue = im_hsv;
    im_hue(:,:,2) = ones(H,W);
    im_hue(:,:,3) = ones(H,W);
    im_hue = hsv2rgb(im_hue);
%     figure,
%     imshow(im_hue);


    %convert to hsv and show histogram
    [H,W] = size(im_h);
    im_hsv_hist = zeros(1,361);
    for h = 1:H
        for w = 1:W
            im_hsv_hist(im_h(h,w)+1) = im_hsv_hist(im_h(h,w)+1) + 1;
        end
    end
    im_hsv_hist = im_hsv_hist(1,1:360);
    
    %% plotting hue bar
    % plhu = 0:1/360:1;
    % plhu1 = [];
    % for x = 1:10
    %     plhu1 = [plhu1;plhu];
    % end
    % imnew = zeros(10,361,3);
    % imnew(:,:,1) = plhu1;
    % imnew(:,:,2) = ones(10,361);
    % imnew(:,:,3) = ones(10,361);
    % imnew = hsv2rgb(imnew);
    % %subplot(2,1,2);
    % %imshow(imnew);

    %% calculate distance of image and template
    allScore = zeros(1,7);
    allBound = cell(8);
    [~,hue_len] = size(im_hsv_hist);

    % %type i 
    M = [1;0.05];
    [allScore(1),bound] = calcTypeScore2(im_hsv,M,hue_len);
    %hue_circle_hist(im_hsv_hist,true,bound);
    allBound{1} = bound;
    % 
    % %type V
     M = [1;0.26];
    [allScore(2),bound] = calcTypeScore2(im_hsv,M,hue_len);
    %hue_circle_hist(im_hsv_hist,true,bound);
    allBound{2} = bound;
    % 
    % %type L
     M = [1,round(90-360*(0.11-0.025));0.05,0.22];
    [allScore(3),bound] = calcTypeScore2(im_hsv,M,hue_len);
    %hue_circle_hist(im_hsv_hist,true,bound);
    allBound{3} = bound;

    % 
    % %type I
    M = [1,180;0.05,0.05];
    [allScore(4),bound] = calcTypeScore2(im_hsv,M,hue_len);
    %hue_circle_hist(im_hsv_hist,true,bound);
    allBound{4} = bound;
    % 
    % % type T
     M = [1;0.5];
    [allScore(5),bound] = calcTypeScore2(im_hsv,M,hue_len);
    %hue_circle_hist(im_hsv_hist,true,bound);
    allBound{5} = bound;
    % 
    % % type Y
     M = [1,round(180+360*(0.13-0.025));0.26,0.05];
    [allScore(6),bound] = calcTypeScore2(im_hsv,M,hue_len);
    %hue_circle_hist(im_hsv_hist,true,bound);
    allBound{6} = bound;
    % 
    % % type X
    M = [1,180;0.26,0.26];
    [allScore(7),bound] = calcTypeScore2(im_hsv,M,hue_len);
    %hue_circle_hist(im_hsv_hist,true,bound);
    allBound{7} = bound;
    % 
 
    [minScore, idx] = min(allScore);% idx is the best fixed template
   
    optBound = allBound{idx}; % optBound is the best fixed template's bound set
    hue_circle_hist(im_hsv_hist,true,optBound);

    disp('best tamplate');
    disp(idx);
    %% transfer the color to best match template
    [ recoverH, im_wheel ] = naiveSectorCut(optBound, im_hsv, hue_len, im_hsv_hist, 0 );
    
    im_hsv(:,:,1) = recoverH;
    imRecover = hsv2rgb(im_hsv);
%     figure,
%     imshow(imRecover);

end
