file_dir = 'Video1/';
filenames = dir([file_dir '*.jpg']);

frame = imread([file_dir filenames(870).name]);
figure(1); h1 = imshow(frame);

for k = 1 : size(filenames,1)
    
    % Create 1-D grayscale vector of image
    frame = imread([file_dir filenames(k).name]);
    set(h1, 'CData', frame);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end