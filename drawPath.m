function [image,highestReached] = drawPath(path,r,g,b, image, highestReached)

found = find(path(:,1));

for k=1 : length(found)
       
    center = path(k,:);
      
    %flip and cast to int in order to draw
    flippedCenter = fliplr(uint16(center));
    
    %draws path of object
    if flippedCenter(1) > 0 && flippedCenter(2) > 0
        image(flippedCenter(1), flippedCenter(2),:) = [r g b];
    end
end

end

