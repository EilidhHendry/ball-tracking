function image = drawRect(image, rect, R, G, B)

rect = uint16(rect);

for k=rect(1) : rect(1) + rect(3)
    image(rect(2),k,:) = [R G B];
end

for k=rect(2) : rect(2) + rect(4)
    image(k,rect(1),:) = [R G B];
end

for k=rect(1) : rect(1) + rect(3)
    image(rect(2) + rect(4),k,:) = [R G B];
end

for k=rect(2) : rect(2) + rect(4)
    image(k,rect(1) + rect(3),:) = [R G B];
end

end

