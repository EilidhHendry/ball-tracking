% Computes a median background from a set of frames

function medianBG = RGBmedianBG(directory, filenames, count)

disp('Computing median background...')

% Initialise the three channels

red = zeros(480,640,50);
blue = zeros(480,640,50);
green  = zeros(480,640,50);

% Store the values of each frame for each channel

for k = 1 : count
    
    frame = imread([directory filenames(count).name]);
    red(:,:,k) = frame(:,:,1);
    blue(:,:,k) = frame(:,:,2);
    green(:,:,k) = frame(:,:,3);
    
end

% Get the median for each of the channels

medred = median(red,3);
medblue = median(blue,3);
medgreen = median(green,3);

% Save the median values as the median background image

medianBG = zeros(480,640,3);
medianBG(:,:,1) = medred;
medianBG(:,:,2) = medblue;
medianBG(:,:,3) = medgreen;

disp('Done!')

end
