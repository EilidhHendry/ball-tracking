function [image,highestReached, highestPoint] = drawPath(path,r,g,b, image, highestReached, highestPoint)

%if there is no path and the threshold is 1 set it to 0 again (to clear
%path)
if path(1)==0 && highestReached==1
    highestPoint = [5 5];
    highestReached=0;
end

found = find(path(:,1));

for k=1 : length(found)
     
    center = path(k,:);
       
    %if there is more than 25 points found to handle noise
    if length(found)>25
        if k>3
            y=1;
            dist=euclidDist((path(k,:)),(path(k-1,:)));
            dist2=euclidDist((path(k-2,:)),(path(k-1)));
            totalDist=dist+dist2;

        %Check if the current point is lower than the previous point
            if center(2)>path(k-1,2) && highestReached==0 && totalDist>4
                %pause(3);
                highestPoint=fliplr(uint16(center));
                highestReached=1;
            end
        end
    end

    %flip and cast to int in order to draw
    flippedCenter = fliplr(uint16(center));

    %draws path of object
    if flippedCenter(1) > 0 && flippedCenter(2) > 0
        
        image(flippedCenter(1), flippedCenter(2),:) = [r g b];
        if highestReached == 1
            image(highestPoint(1), highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)+1, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)+2, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)+3, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)-1, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)-2, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)-3, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)+1,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)+2,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)+3,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)-1,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)-2,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)-3,:) = [255 255 255];
        end
        
    end
end

end

