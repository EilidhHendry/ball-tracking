function result = isNoise(BinaryImage, Xcoord, Ycoord)

if BinaryImage(Xcoord + 1, Ycoord) == 0 ...
    && BinaryImage(Xcoord - 1, Ycoord) == 0 ...
    && BinaryImage(Xcoord, Ycoord + 1) == 0 ...
    && BinaryImage(Xcoord, Ycoord - 1) == 0
    result = 1; 
else
    result = 0;
end

end

