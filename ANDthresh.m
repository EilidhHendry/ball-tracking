% Creates an image of the moving objects without
% the background.

% The three channels of the binary matrix are logical
% AND'd together to obtain a 2D binary image.

% AND reduces noise but can result in less recall for
% the desired pixels. This works better for HSV images,
% but requires finely tuned thresholds.

function binaryImage2D = ANDthresh(binaryImage3D)

    % We logical OR the matrices for each channel together
    % In order to preserve the original output for the included pixels
    binaryImage2D = binaryImage3D(:,:,1) & binaryImage3D(:,:,2) & binaryImage3D(:,:,3);

end

