function normalizedimage = normalize(rgbimage)

%NORMALIZE Normalizes an image using value histogram equalization

hsvimage = rgb2hsv(rgbimage);
V = histeq(hsvimage(:,:,3));
hsvimage(:,:,3) = V;
normalizedimage = 255 * hsv2rgb(hsvimage);


end

