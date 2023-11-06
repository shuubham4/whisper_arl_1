import os
import re

regexp = '(^\s*[/*])|(^\s*$)'
rootdir = "/home/shuubham/Desktop/spine1_train/whisper_train/noisy_files/path_to_clips/validation"

for subdir, dirs, filenames in os.walk(rootdir):
    for file in filenames:
        count = 0
        if file.endswith("_base.txt"):
            with open(os.path.join(subdir,file)) as f1:
                inp = f1.readlines()   
                for i in range(len(inp)):
                    if not re.search(regexp, inp[i]):
                        count += 1
                print(count)  
                if count != 762:
                    print(str(os.path.join(subdir,file)))          




