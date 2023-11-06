import csv
import os
import sys
import datasets
import random
import shutil
import soundfile as sf
import numpy as np

inst = sys.argv
noise_type=str(inst[1])
snr=str(inst[2])
# create another level of nesting with directory in that ..
directory = "/home/shuubham/Desktop/spine1_train/whisper_zeroshot/libri_subset_mix_with_noise_at_"+snr+"db/libri_"+noise_type+"_"+snr

class NewTestData(datasets.GeneratorBasedBuilder):
    def __init__(self, noise_type, snr):
        self.directory = directory
        self.noise_type = noise_type
        self.snr = snr

    def _generateeg(self):    
        examples = {}
        id_ = 0
        rows = open("/home/shuubham/Desktop/spine1_train/whisper_zeroshot/groundtruth1.txt",'r').readlines()
        # prompts_path is to be a file in train directory ..
        # making directory an input 
        for filename in os.listdir(directory):
            prompts_path = os.path.join(directory, filename)
            with open(prompts_path,'rb') as f:
                data = prompts_path.split("/")
                speaker_id = data[-1].split("-")[0] 
                readrow = rows[id_]
                sentence = rows[id_].split(" ",1)[1]
                examples[prompts_path] = {
                    "speaker_id": speaker_id,
                    "path": prompts_path,
                    "sentence": sentence  
                }      
                audio, sample_rate = sf.read(f)
                audio = np.array(audio)
                id_ += 1
                yield examples[prompts_path]['speaker_id'], examples[prompts_path]['path'], sample_rate, examples[prompts_path]['sentence']

with open("test_arl.csv", "w") as test_arl:
    writer = csv.writer(test_arl)
    #writer.writerow(['SpeakerId','Audio_Path','Sample_Rate','Sentence'])
    first = NewTestData(noise_type, snr)
    gen = first._generateeg()
    for i in gen:
        writer.writerow(i)                          