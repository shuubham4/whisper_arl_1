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
dst = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/train" 

class NewDataset(datasets.GeneratorBasedBuilder):
    def __init__(self, directory):
        self.directory = directory

    def _generateeg(self):    
        examples = {}
        # prompts_path is to be a file in train directory ..
        # making directory an input 
        for filename in os.listdir(dst):
            data = filename.split("-",2)
            lineno = data[2].split(".")[0]
            f = "/home/shuubham/Desktop/spine1_train/speech/ground/"+data[0]+"-"+data[1]+".trans.txt"
            with open(f,'r') as f1:
                lines = f1.readlines()
                speaker_id = data[0]
                audio_path = os.path.join(dst+"/"+filename)
                sentence = lines[int(lineno)].split(" ",1)[1]
                examples[audio_path] = {
                    "speaker_id": speaker_id,
                    "path": audio_path,
                    "sentence": sentence
                }   

        for path in examples.keys():
            with open(examples[path]["path"], 'rb') as f: 
                audio, sample_rate = sf.read(f)
                audio = np.array(audio)
                yield examples[path]['speaker_id'], examples[path]['path'], sample_rate, examples[path]['sentence']
                     
with open("dataset_arl.csv", "w") as dataset_arl:
    writer = csv.writer(dataset_arl)
    #writer.writerow(['SpeakerId','Audio_Path','Sample_Rate','Sentence'])
    first = NewDataset(directory)
    gen = first._generateeg()
    for i in gen:
        writer.writerow(i)    



    