function center = getCenter(image)

area = length(find(image(:,:,1)));

xsum = 0;
ysum = 0;

values = find(image(:,:,1));

for k = 1 : length(values)
    image(values(k)) = 1;
end

for i = 1 : 480
    for j = 1 : 640
        xsum = xsum + (i * image(i,j,1));
        ysum = ysum + (j * image(i,j,1));
    end
end

center = [uint8(xsum/area) uint8(ysum/area)] + 1;

end

