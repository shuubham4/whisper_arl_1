delete('/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train/*.wav') 
path = '/home/shuubham/Desktop/spine1_train/speech_wav/train';
file_list = dir(fullfile(path));
% randomize file_list here:
n_files = length(file_list);
rand_indices = randperm(n_files, n_files);
%sampled_files = file_list(rand_indices);
sampled_files = file_list;
snrset = [-3, 0, 3, 6, 9 , 12];
%order_to_use = randperm(n_files);
order_to_use = 1:n_files;

for j = 1:6
    %snr = snrset(randi(numel(snrset), 1, 1));
    snr = snrset(j);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        fprintf('%s , %s', num2str(j),num2str(i));
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t == 1
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_artillery_rain.wav', destFileName, snr);
        end    
    end    
end 

for j = 7:12
    snr = snrset(j-6);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_airstrikes.wav', destFileName, snr); 
        end
    end    
end 

for j = 13:18
    snr = snrset(j-12);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        fprintf('%s , %s', num2str(j),num2str(i));
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_blitz.wav', destFileName, snr); 
        end 
    end    
end 

for j = 19:24
    snr = snrset(j-18);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_fighter_choppers.wav', destFileName, snr);
        end    
    end    
end 

for j = 25:30
    snr = snrset(j-24);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        fprintf('%s , %s', num2str(j),num2str(i));
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_pistol.wav', destFileName, snr);  
        end    
    end    
end 

for j = 31:36
    snr = snrset(j-30);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_tank.wav', destFileName, snr);
        end    
    end    
end 

for j = 37:42
    snr = snrset(j-36);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_radio_comm.wav', destFileName, snr);    
        end    
    end    
end 
 
for j = 43:48
    snr = snrset(j-42);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1       
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_war.wav', destFileName, snr); 
        end
    end    
end 

for j = 49:54
    snr = snrset(j-48);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_w_t.wav', destFileName, snr);       
        end    
    end
end 

for j = 55:60
    snr = snrset(j-54);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        fprintf('%s , %s', num2str(j),num2str(i));
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
            mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_ww1.wav', destFileName, snr);
        end 
    end    
end 
 
for j = 61:66
    snr = snrset(j-60);
    for i = 305*(j-1)+1:305*j
        baseFileName = sampled_files(order_to_use(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train", baseFileName);
        t = endsWith(sampled_files(order_to_use(i)).name,".wav");
        if t==1        
           mixFiles(strcat(sampled_files(order_to_use(i)).folder,'/',sampled_files(order_to_use(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_ww1_realistic.wav', destFileName, snr); 
        end
    end    
end 







    