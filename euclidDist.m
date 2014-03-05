function dist = euclidDist(pt1, pt2)

if ~isempty(pt1) && ~isempty(pt2)
    dist  = sqrt(sum((pt1 - pt2) .^ 2));
else
    dist = 5000000000;
end

end

