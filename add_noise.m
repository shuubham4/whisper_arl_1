%diary on
%diary /home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/logfile.txt

myDir = '/home/shuubham/Desktop/spine1_train/speech_wav';
myFiles = dir(fullfile(myDir,'*.wav'));

for snr = 6:3:12
    myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/artillery_rain';
    mkdir(fullfile(myDir_tget,num2str(snr)));
    myDir_tget1 = fullfile(myDir_tget,num2str(snr));
    for k = 1:length(myFiles)
      baseFileName = myFiles(k).name;
      fullFileName = fullfile(myDir, baseFileName);
      fullFileName_tget = fullfile(myDir_tget1, baseFileName);
      splitted_name = split(myDir_tget1,"/");
      fprintf('%s ',string(splitted_name(end)));
      fprintf(1, 'Now reading %s\n', fullFileName);
      mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_artillery_rain.wav', fullFileName_tget, snr);
    end
end

% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/blitz';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_blitz.wav', fullFileName_tget, snr);
%     end
% end

% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/airstrikes';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_airstrikes.wav', fullFileName_tget, snr);
%     end
% end

% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/pistol';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_pistol.wav', fullFileName_tget, snr);
%     end
% end
 
% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/tank';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_tank.wav', fullFileName_tget, snr);
%     end
% end

% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/war';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));   
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_war.wav', fullFileName_tget, snr);
%     end
% end
 
% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/w_t';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));     
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_w_t.wav', fullFileName_tget, snr);
%     end
% end

% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/ww1';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));   
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_ww1.wav', fullFileName_tget, snr);
%     end
% end
 
% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/ww1_realistic';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));      
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_ww1_realistic.wav', fullFileName_tget, snr);
%     end
% end

% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/radio_comm';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));      
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_radio_comm.wav', fullFileName_tget, snr);
%     end
% end

% for snr = -3:3:12
%     myDir_tget = '/home/shuubham/Desktop/spine1_train/whisper_zeroshot/noisy_files/fighter_choppers';
%     mkdir(fullfile(myDir_tget,num2str(snr)));
%     myDir_tget1 = fullfile(myDir_tget,num2str(snr));      
%     for k = 1:length(myFiles)
%       baseFileName = myFiles(k).name;
%       fullFileName = fullfile(myDir, baseFileName);
%       fullFileName_tget = fullfile(myDir_tget1, baseFileName);
%       splitted_name = split(myDir_tget1,"/");
%       fprintf('%s ',string(splitted_name(end)));
%       fprintf(1, 'Now reading %s\n', fullFileName);
%       mixFiles(fullFileName, '/home/shuubham/Desktop/spine1_train/noises/new_fighter_choppers.wav', fullFileName_tget, snr);
%     end
% end


  