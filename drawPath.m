function image = drawPath(path, image)

found = find(path(:,1));

for k=1 : length(found)
    center = fliplr(uint16(path(k,:)));
    image(center(1), center(2),:) = [255 0 0];
end

end

