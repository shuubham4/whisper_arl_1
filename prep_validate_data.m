path = '/home/shuubham/Desktop/spine1_train/speech_wav/validation/*.wav';
file_list = dir(fullfile(path));
random_indices = randperm(length(file_list),length(file_list));
prep_validate_data1(-3, file_list, random_indices);
prep_validate_data1(0, file_list, random_indices);
prep_validate_data1(3, file_list, random_indices);
prep_validate_data1(6, file_list, random_indices);
prep_validate_data1(9, file_list, random_indices);
prep_validate_data1(12, file_list, random_indices);

function prep_validate_data1(snr, file_list, random_indices)
    %delete(strcat('/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/',num2str(snr),'/*/*.wav')); 
    for i = 1:762
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile('/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/',num2str(snr),'/artillery_rain', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_artillery_rain.wav', destFileName, snr);   
    end 
    
     for i = 763:1524
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/airstrikes', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_airstrikes.wav', destFileName, snr);   
     end 
    
      for i = 1525:2286
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/blitz', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_blitz.wav', destFileName, snr);   
      end 
   
     for i = 2287:3048
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/fighter_choppers', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_fighter_choppers.wav', destFileName, snr);   
     end     
   
     for i = 3049:3810
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/pistol', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_pistol.wav', destFileName, snr);   
     end 
    
     for i = 3811:4572
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/tank', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_tank.wav', destFileName, snr);   
     end 
    
     for i = 4573:5334
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/war', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_war.wav', destFileName, snr);   
     end 
    
     for i = 5335:6096
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/radio_comm', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_radio_comm.wav', destFileName, snr);   
     end 
    
     for i = 6097:6858
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/w_t', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_w_t.wav', destFileName, snr);   
     end 
    
      for i = 6859:7620
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/ww1', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_ww1.wav', destFileName, snr);   
      end 
    
     for i = 7621:8382
        baseFileName = file_list(random_indices(i)).name;
        destFileName = fullfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/",num2str(snr),'/ww1_realistic', baseFileName);
        mixFiles(strcat(file_list(random_indices(i)).folder,'/',file_list(random_indices(i)).name), '/home/shuubham/Desktop/spine1_train/noises/new_ww1_realistic.wav', destFileName, snr);   
    end      
end

