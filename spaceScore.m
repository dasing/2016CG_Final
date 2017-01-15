%extract score sum over those pixel in the range [low,high]

function score = spaceScore(map,low,high)
[H,W] = size(map);
map_low = zeros(1,W);
map_high = zeros(1,W);
map_num = 1:W;


map_low(map_num>=low) = 1;
map_high(map_num<=high) = 1;

if (low<high)
    map_temp  = map_low .* map_high;
else
    map_temp = map_low + map_high;
end

%map_temp = reshape(map_temp,H,W);
mapout = map.*map_temp;
score = sum(sum(mapout));

end