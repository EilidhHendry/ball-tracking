function image = drawPath(image, centers)

if ~isempty(centers)
    for k = 1 : length(centers(:,1))
        if  centers(k,1) > 2 && centers(k,2)  > 2
            image(centers(k,1),centers(k,2),:) = [255 0 0];
            image(centers(k,1)+1,centers(k,2),:) = [255 0 0];
            image(centers(k,1)-1,centers(k,2),:) = [255 0 0];
            image(centers(k,1),centers(k,2)+1,:) = [255 0 0];
            image(centers(k,1),centers(k,2)-1,:) = [255 0 0];
        end
    end
end

end

