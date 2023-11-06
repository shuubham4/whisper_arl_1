import csv
import os
import sys
import datasets
import random
import shutil
import soundfile as sf
import numpy as np

inst = sys.argv
# the directory for ground truth
directory = "/home/shuubham/Desktop/spine1_train/speech/ground/"
directory=str(inst[1])
# this has to be directory to audio file .. 
# use snr and noise type to get path to noisy audio file
noise_type=str(inst[2])
snr=str(inst[3])


# this gives 100 random files in train directory for each snr and noise type
# this should be roughly 27.5 hours of speech per epoch 
directory_path = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files"+"/"+noise_type+"/"+snr
dst = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train" 
# remove all existing files from dst path first
del_files = os.listdir(dst)
for file_name in del_files:
    file_path = os.path.join(dst, file_name)
    os.remove(file_path)

all_files = os.listdir(directory_path)
random_files = random.sample(all_files, 100)
for file_name in random_files:
    file_path = os.path.join(directory_path, file_name)
    shutil.copy(file_path, dst)

class NewDataset(datasets.GeneratorBasedBuilder):
    def __init__(self, directory, noise_type, snr):
        self.directory = directory
        self.noise_type = noise_type
        self.snr = snr

    def _generateeg(self):    
        examples = {}
        # prompts_path is to be a file in train directory ..
        # making directory an input 
        for filename in os.listdir(directory):
            prompts_path = os.path.join(directory, filename)
            with open(prompts_path, encoding="utf-8") as f:
                for row in f:
                    data = row.strip().split("-",1)
                    speaker_id = data[0]
                    data4path = row.strip().split(" ",1) 
                    audio_path = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files"+"/"+noise_type+"/"+snr+"/"+data4path[0]+".flac"+".wav"
                    examples[audio_path] = {
                        "speaker_id": speaker_id,
                        "path": audio_path,
                        "sentence": data4path[1],
                    }
        inside_clips_dir = False
        id_ = 0
        for path in examples.keys():
            with open(path, encoding="utf-8") as f:
                if os.path.isfile("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train/"+path.split("/")[-1]):     
                    inside_clips_dir = True
                    with open("/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train/"+path.split("/")[-1], 'rb') as f1:    
                        audio, sample_rate = sf.read(f1)
                        audio = np.array(audio)
                        yield examples[path]['speaker_id'], examples[path]['path'], sample_rate, examples[path]['sentence']
                        id_ += 1
                     
with open("dataset_arl.csv", "w") as dataset_arl:
    writer = csv.writer(dataset_arl)
    #writer.writerow(['SpeakerId','Audio_Path','Sample_Rate','Sentence'])
    first = NewDataset(directory, noise_type, snr)
    gen = first._generateeg()
    for i in gen:
        writer.writerow(i)    



    