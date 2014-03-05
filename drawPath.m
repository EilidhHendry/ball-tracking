function [image,highestReached] = drawPath(path,r,g,b, image, highestReached)

found = find(path(:,1));

if path(1)==0 & highestReached==1
    highestReached=0;
end

for k=1 : length(found)
     
    center = path(k,:);
    
    if length(found)>25
        if k>1
            test=path(k-1,2);
        end  
        %Check if the current point is lower than the previous point
        if k>1 & center(2)>test & highestReached==0
            pause(3);
            highestReached=1;
        end
    end

    %flip and cast to int in order to draw
    flippedCenter = fliplr(uint16(center));

    %draws path of object
    image(flippedCenter(1), flippedCenter(2),:) = [r g b];

end

end

