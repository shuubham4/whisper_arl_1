from jiwer import wer
import os
import sys
import string
import array
import re

def sentence_matcher(s1,s2):
    l1 = len(s1)
    l2 = len(s2)
    diff = l1-l2
    for i in range(diff):
        s2.append("x ")
    return s2

def list2str(inp):
    sentence = ''
    for x in inp:
        sentence +=' ' + x
    return sentence

inst = sys.argv

snr=str(inst[1])
noise_type=str(inst[2])

input1 = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/"+snr+"/"+noise_type

ground = "/home/shuubham/Desktop/spine1_train/speech/ground"

out_file = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation/"+snr+"/"+noise_type+"/"+"wer.txt"

for filename in os.listdir(input1):
    error = []
    if filename.endswith('_base.txt'):          # change for different model size
        with open(os.path.join(input1, filename)) as f2:
            in_data=f2.readlines()
            # opened the validation.txt file at this point
            for i in range(len(in_data)):
                if (in_data[i] != '\n'):
                    in_data[i] = re.sub(r"  ", " ", in_data[i])
                    label = in_data[i].split(" ")[0]
                    splitted_label = label.split("-")
                    if len(splitted_label) == 3:
                        filnm = splitted_label[0]+"-"+splitted_label[1]+".trans.txt" 
                        # go to label lineno inside ground/filnm
                        with open(os.path.join(ground, filnm)) as fg:
                            gr_data = fg.readlines()
                            for j in range(len(gr_data)):
                                gsp = gr_data[j].split(" ")
                                if label.translate(str.maketrans('','',string.punctuation)) == gsp[0].translate(str.maketrans('','',string.punctuation)):
                                    st1 = gr_data[j].translate(str.maketrans('', '', string.punctuation))
                                    st2 = in_data[i].translate(str.maketrans('', '', string.punctuation))
                                    gr_data[j] = st1 
                                    in_data[i] = st2    
                                    error.append(wer(gr_data[j].upper(), in_data[i].upper()))
                            fg.close()   

            out_txt =  "wer for base model is " + str((sum(error)/len(error)))+ "\n"   # change for different model 
            f3 = open(out_file, "a")
            f3.write(out_txt)
            f3.close()
            f2.close()            
















