from datasets import Dataset, load_dataset, concatenate_datasets, DatasetDict
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
import os

feature_extractor = WhisperFeatureExtractor.from_pretrained("openai/whisper-base")
tokenizer = WhisperTokenizer.from_pretrained("openai/whisper-base", language="English", task="transcribe")
processor = WhisperProcessor.from_pretrained("openai/whisper-base", language="English", task="transcribe")

@dataclass
class DataCollatorSpeechSeq2SeqWithPadding:
    processor: Any
    def __call__(self, features: List[Dict[str, Union[List[int], torch.Tensor]]]) -> Dict[str, torch.Tensor]:
        input_features = [{"input_features": feature["input_features"]} for feature in features]
        batch = self.processor.feature_extractor.pad(input_features, return_tensors="pt")
        label_features = [{"input_ids": feature["labels"]} for feature in features]
        labels_batch = self.processor.tokenizer.pad(label_features, return_tensors="pt")
        labels = labels_batch["input_ids"].masked_fill(labels_batch.attention_mask.ne(1), -100)
        if (labels[:, 0] == self.processor.tokenizer.bos_token_id).all().cpu().item():
            labels = labels[:, 1:]
        batch["labels"] = labels
        return batch

data_collator = DataCollatorSpeechSeq2SeqWithPadding(processor=processor)

metric = evaluate.load("wer")
def compute_metrics(pred):
    pred_ids = pred.predictions
    label_ids = pred.label_ids
    label_ids[label_ids == -100] = tokenizer.pad_token_id
    pred_str = tokenizer.batch_decode(pred_ids, skip_special_tokens=True)
    label_str = tokenizer.batch_decode(label_ids, skip_special_tokens=True)
    wer = 100 * metric.compute(predictions=pred_str, references=label_str)
    return {"wer": wer}

#model = WhisperForConditionalGeneration.from_pretrained("openai/whisper-base") # change here for training a fine tuned model 
model = WhisperForConditionalGeneration.from_pretrained("/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_base/iter4/checkpoint-2000")
model.config.forced_decoder_ids = None 
model.config.suppress_tokens = []
model.config.use_cache = False

custom_dataset = DatasetDict()
custom_dataset["train"] = DatasetDict()
custom_dataset["test"] = DatasetDict()
custom_dataset["train"] = Dataset.load_from_disk(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_medium/train/train_chunk_0/")
custom_dataset["test"] = Dataset.load_from_disk(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_medium/test/test_chunk_0/")


for chunck in os.listdir(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_medium/train"):
    custom_dataset["train"] = concatenate_datasets([custom_dataset["train"], Dataset.load_from_disk(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_medium/train/{chunck}")])

for chunck in os.listdir(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_medium/test"):
    custom_dataset["test"] = concatenate_datasets([custom_dataset["test"], Dataset.load_from_disk(f"/home/shuubham/Desktop/spine1_train/whisper_train/whisper_arl_medium/test/{chunck}")])    

torch.cuda.empty_cache()

training_args = Seq2SeqTrainingArguments(
    output_dir="./whisper_arl_base",  
    per_device_train_batch_size=16,
    gradient_accumulation_steps=1,  
    learning_rate=1e-5,
    warmup_steps=500,
    max_steps=2000, 
    gradient_checkpointing=True,
    fp16=True,
    evaluation_strategy="steps",
    per_device_eval_batch_size=8,
    predict_with_generate=True,
    generation_max_length=225,
    save_steps=1000,
    eval_steps=500,
    logging_steps=500,
    report_to=["tensorboard"],
    load_best_model_at_end=True,
    metric_for_best_model="wer",
    greater_is_better=False,
    push_to_hub=False,
)  

trainer = Seq2SeqTrainer(
    args=training_args,
    model=model,
    train_dataset=custom_dataset["train"] ,
    eval_dataset=custom_dataset["test"] ,
    data_collator=data_collator,
    compute_metrics=compute_metrics,
    tokenizer=processor.feature_extractor,
    callbacks=[EarlyStoppingCallback(early_stopping_patience=5)],
)

trainer.train()






