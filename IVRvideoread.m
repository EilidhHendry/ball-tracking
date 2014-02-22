
file_dir = 'Video1'; %put here one of the folder locations with images;
filenames = dir([file_dir '*.jpg']);

frame = imread([file_dir filenames(1).name]);
figure(1); h1 = imshow(frame);

% Read one frame at a time.
for k = 1 : size(filenames,1)
    frame = imread([file_dir filenames(k).name]);
    set(h1, 'CData', frame);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end