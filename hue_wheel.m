%draw a hue wheel
%%  draw hue circle 2

Size = [400,400];
im = ones(Size(1),Size(2),3);
im(:,:,2) = zeros(Size(1),Size(2));
baseVector = [0,1];
center = [floor(Size(1)/2),floor(Size(2)/2)];
radius = round(Size(1)/4);
wheelthick = round(radius/5);

for h = 1:Size(1)
    for w = 1:Size(2)
        pairp = [h,w;center(1),center(2)];
        dist = pdist(pairp,'Euclidean');
        if( dist< radius && dist > radius - wheelthick)
            nowVec = [h-center(1),w-center(2)];
            costheta = dot(nowVec, baseVector)/(norm(baseVector)*norm(nowVec));
            if h < 200 
                theta = acos(costheta);
            else
                theta = 2*pi - acos(costheta);
            end
            im(h,w,1) = theta/(2*pi);
            im(h,w,2) = 1;
                 
        end
    end
end
im = hsv2rgb(im);
figure,
imshow(im);
imwrite(im,'hue_wheel.jpg');


