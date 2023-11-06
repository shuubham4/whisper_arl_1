from datasets import Dataset, load_dataset
from transformers import WhisperTokenizer
from transformers import WhisperProcessor
from transformers import WhisperForConditionalGeneration
from transformers import WhisperFeatureExtractor
import torch
import whisper
import sys
import soundfile as sf
import numpy as np
import os

inst=sys.argv
snr=str(inst[1])
noise_type=str(inst[2])

tokenizer = WhisperTokenizer.from_pretrained("openai/whisper-base", language="English", task="transcribe")
processor = WhisperProcessor.from_pretrained("openai/whisper-base", language="English", task="transcribe", sampling_rate = 16000)
feature_extractor = WhisperFeatureExtractor.from_pretrained("openai/whisper-large-v2", device="cuda")
model = WhisperForConditionalGeneration.from_pretrained("/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_base/checkpoint-2000", return_dict=False)
model.config.forced_decoder_ids = None 
model.config.suppress_tokens = []
model.config.use_cache = False
path = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/"+snr+"/"+noise_type
file_list = os.listdir(path)
out_file = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/"+snr+"/"+noise_type+"/transcription_base.txt"

for file_name in file_list:
    with open(os.path.join(path,file_name), 'rb') as f1:
        if file_name.endswith(".wav"):
            audio, sample_rate = sf.read(f1)
            audio = np.array(audio)
            #inputs = processor(audio, return_tensors="pt", sampling_rate = 16000)
            #input_features = inputs.input_features
            input_features = feature_extractor(audio, sampling_rate=16000, return_tensors="pt").input_features
            generated_ids = model.generate(inputs=input_features,no_repeat_ngram_size=8)
            transcription = processor.batch_decode(generated_ids, skip_special_tokens=True)[0]
            with open(out_file,"a") as f:
                label = file_name.split(".")[0]
                f.write(str(label).rstrip('\n'))
                f.write(" ")
                f.write(transcription)   
                f.write('\n')  