[Y,FS] = audioread('/home/shuubham/Desktop/spine1_train/noises/airstrikes.wav');  % Your file name
num_samp = round(FS); % Number of samples in a sec
audiowrite('/home/shuubham/Desktop/spine1_train/noises/new_airstrikes.wav',Y(140*num_samp:160*num_samp,:), FS);