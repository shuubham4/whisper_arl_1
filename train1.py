from datasets import Dataset
import pandas as pd
from datasets import Audio
import gc
from transformers import WhisperFeatureExtractor
from transformers import WhisperTokenizer
from transformers import WhisperProcessor
from transformers import Seq2SeqTrainer
from transformers import Seq2SeqTrainingArguments
from transformers import WhisperForConditionalGeneration
import evaluate
import torch
from dataclasses import dataclass
from typing import Any, Dict, List, Union
import array
from transformers import EarlyStoppingCallback

feature_extractor = WhisperFeatureExtractor.from_pretrained("openai/whisper-medium")
tokenizer = WhisperTokenizer.from_pretrained("openai/whisper-medium", language="English", task="transcribe")
processor = WhisperProcessor.from_pretrained("openai/whisper-medium", language="English", task="transcribe")

def prepare_dataset(examples):
    audio = examples["Audio_Path"]
    examples["input_features"] = feature_extractor(audio["array"], sampling_rate=16000).input_features[0]
    del examples["Audio_Path"]
    sentences = examples["Sentence"]
    examples["labels"] = tokenizer(sentences).input_ids
    del examples["Sentence"]
    del examples["Sample_Rate"]
    del examples["SpeakerID"]
    return examples

train_df = []
test_df = []
train_dataset = []
test_dataset = []
Chunksize = 100
chunks_train = pd.read_csv("/home/shuubham/Desktop/spine1_train/whisper_train/dataset_arl.csv", chunksize=Chunksize)
chunks_test = pd.read_csv("/home/shuubham/Desktop/spine1_train/whisper_train/validation_arl.csv", chunksize=Chunksize)
for chunk in chunks_train:
    train_df.append(chunk) 

for chunk in chunks_test:
    test_df.append(chunk)   

for i in range(len(train_df)):
    train_df[i].columns = ["SpeakerID","Audio_Path", "Sample_Rate","Sentence"]
    train_dataset.append(Dataset.from_pandas(train_df[i]))
    train_dataset[i] = train_dataset[i].cast_column("Audio_Path", Audio(sampling_rate=16000))
    train_dataset[i] = train_dataset[i].map(prepare_dataset, num_proc=1, writer_batch_size=1, batched=False, batch_size=10)
    train_dataset[i].save_to_disk(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_1/train/train_chunk_{i}")


for i in range(len(test_df)):
    test_df[i].columns = ["SpeakerID","Audio_Path", "Sample_Rate", "Sentence"]
    test_dataset.append(Dataset.from_pandas(test_df[i]))
    test_dataset[i] = test_dataset[i].cast_column("Audio_Path", Audio(sampling_rate=16000))
    test_dataset[i] = test_dataset[i].map(prepare_dataset, num_proc=1, writer_batch_size=1, batched=False, batch_size=10)
    test_dataset[i].save_to_disk(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_1/test/test_chunk_{i}")

