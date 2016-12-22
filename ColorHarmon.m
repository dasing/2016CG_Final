% color homorization
%first try

%% read image, remap hue imformation into histogram
im = imread('dog.jpg');
[H,W,~] = size(im);
im_hsv = rgb2hsv(im);
im_h = floor(360 * im_hsv(:,:,1));
m = max(max(im_h));
%imshow((im_h));

%show pure hue image
im_hue = im_hsv;
im_hue(:,:,2) = ones(H,W);
im_hue(:,:,3) = ones(H,W);
im_hue = hsv2rgb(im_hue);
figure,
imshow(im_hue);


%convert to hsv and show histogram
[H,W] = size(im_h);
im_hsv_hist = zeros(1,361);
for h = 1:H
    for w = 1:W
        im_hsv_hist(im_h(h,w)+1) = im_hsv_hist(im_h(h,w)+1) + 1;
    end
end
im_hsv_hist = im_hsv_hist(1,1:360);
hue_circle_hist(im_hsv_hist);

figure,
stem(im_hsv_hist);

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
% type T
deg = 360;
templateT = zeros(1,deg);
templateT(1:floor(deg*0.5)) = ones(floor(deg*0.5));

