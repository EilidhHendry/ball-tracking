% Checks if a pixel is completely isolated from 
% other detected pixels in a binary image.

function result = isNoise(BinaryImage, Ycoord, Xcoord)

if Xcoord > 1 && Ycoord > 1 && Xcoord < 640 && Ycoord < 480
    
    if BinaryImage(Ycoord + 1, Xcoord, 1) == 0 ...
        && BinaryImage(Ycoord - 1, Xcoord, 1) == 0 ...
        && BinaryImage(Ycoord, Xcoord + 1, 1) == 0 ...
        && BinaryImage(Ycoord, Xcoord - 1, 1) == 0
        result = 1; 
    else
        result = 0;
    end
else
    result = 1;
end

end

