% Creates an image of the moving objects without
% the background and with the original colours of
% the image.

% The three channels of the binary matrix are logical
% AND'd together to obtain the original colours.

% AND reduces noise but can result in less recall for
% the desired pixels. This works better for HSV images,
% but requires finely tuned thresholds.

function colorImage = ANDthresh(binaryImage, frame)

    % Convert the frame values to floating point doubles
    frame = double(frame);   

    % We logical OR the matrices for each channel together
    % In order to preserve the original output for the included pixels
    binaryImage(:,:,1) = binaryImage(:,:,1) & binaryImage(:,:,2) & binaryImage(:,:,3);
    binaryImage(:,:,2) = binaryImage(:,:,1) & binaryImage(:,:,2) & binaryImage(:,:,3);
    binaryImage(:,:,3) = binaryImage(:,:,1) & binaryImage(:,:,2) & binaryImage(:,:,3);
    
    % Multiply the logical matrix with the original frame to 
    % retrieve the included pixels' original RGB values
    colorImage = binaryImage .* frame;
        
    % Since the image is in doubles, we want the values between
    % zero and one.
    colorImage = colorImage ./ 255;

end

