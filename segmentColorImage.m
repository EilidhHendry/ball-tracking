% Use the binary image to retrieve the original colours
% for the segmented moving objects.

function colorImage = segmentColorImage(binaryImage, frame)

    % Convert the frame values to floating point doubles
    frame = double(frame); 

    % Multiply the logical matrix with the original frame to 
    % retrieve the included pixels' original RGB values
    colorImage(:,:,1) = binaryImage .* frame(:,:,1);
    colorImage(:,:,2) = binaryImage .* frame(:,:,2);
    colorImage(:,:,3) = binaryImage .* frame(:,:,3);
        
    % Since the image is in doubles, we want the values between
    % zero and one.
    colorImage = colorImage ./ 255;

end

