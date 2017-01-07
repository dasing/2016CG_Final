function wm = weighted_mean(vec, rmin, rmax)

wm = sum(vec(rmin:rmax).*(rmin:rmax))/sum(vec(rmin:rmax));

end
