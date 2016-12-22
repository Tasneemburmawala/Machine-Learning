
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize, sent_tokenize
import os
import shutil
import string
import re
import math
from collections import defaultdict
import operator
def move_files(abs_dirname):
    
    testfolder=os.path.join("c:", os.sep, "", "", "") #Enter the path of the Test Folder Location
    trainfolder=os.path.join("c:", os.sep, "", "", ) #Enter the path of Train Folder Location
    if not os.path.exists(trainfolder):
        os.makedirs(os.path.abspath(trainfolder))
    if not os.path.exists(testfolder):
        os.makedirs(os.path.abspath(testfolder))
    list_dir = os.listdir(abs_dirname)
    
    
    for f in list_dir:
      new_path=os.path.join(abs_dirname, f)
      t=os.listdir(new_path)
      newtest=os.path.join(testfolder,f)
      os.makedirs(os.path.abspath(newtest))
      newtrain=os.path.join(trainfolder,f)
      os.makedirs(os.path.abspath(newtrain))
      
      p=len(t)
      v=math.ceil(0.7*p)
      count = 0
      for f_folder in t:
        src_root=os.path.join(new_path,f_folder)
        count += 1
        if count>v:
            shutil.move(src_root,newtest)
        else:
            shutil.move(src_root,newtrain)    
                         
def trimfiles(files_trim):
    list_dir = os.listdir(files_trim)
    for trainf in list_dir:
        news_folder=os.path.join(files_trim,trainf)
        list_news_folderdir = os.listdir(news_folder)
        for news_folder_file in list_news_folderdir:
            path_to_file=os.path.join(news_folder,news_folder_file)
            file_content = open(os.path.abspath(path_to_file))
            lineNum = 0;
            for num, line in enumerate(file_content, 1):
                if "Lines:" in line:
                    lineNum = int(num)
            file_content1= "".join(open(os.path.abspath(path_to_file)).readlines()[lineNum:]);
            target=open(os.path.abspath(path_to_file),'w+')
            file_content2= target.write(file_content1)
            target.close()
            
def train_computation(trainfolder_path):
    list_traindir = os.listdir(trainfolder_path)
    another_dict = {}
    uniquewords=[]
    uniquewords_ln=0
    parenttraindict = {}
    for i,trainf in enumerate(list_traindir):
        print(trainf)
        dict_name = 'dict'
        vars()['dict_name'] = 'dict' + str(trainf)
        dict_name={}
        train_folder=os.path.join(trainfolder_path,trainf)
        list_train_folderdir = os.listdir(train_folder)
        for train_folder_file in list_train_folderdir:
        
            path_to_file=os.path.join(train_folder,train_folder_file)
            f = open(os.path.abspath(path_to_file), "r")
            s = f.read()
            removeSpecialChars = s.translate ({ord(c): " " for c in "'!@#$%^&*()[]{};:,./<>?\|`~-=_+"})
            wordsxx = removeSpecialChars.split()

            stop_words=set(stopwords.words("english"))

            filtered_sentence=[]
            for w in wordsxx:
                if w not in stop_words:
                    filtered_sentence.append(w)
            ll = [x for x in filtered_sentence if not re.fullmatch('[' + string.punctuation + ']+', x)]

            no_integers = [x for x in ll if not (x.isdigit() 
                                         or x[0] == '-' and x[1:].isdigit())]

            wordst = [word.lower() for line in no_integers for word in line.split()] 
            line = [i for i in wordst if len(i) > 1]

            finalwords=[]
            for o in line:
                if o.isalpha():
                    finalwords.append(o)
                else:
                    line.remove(o)
            f.close()
    #words and their count in each file of each class
            for singleword in finalwords:
                if singleword in dict_name:
                    dict_name[singleword]+=1
                else:
                    dict_name[singleword]=1
                if singleword not in uniquewords:
                    uniquewords.append(singleword)
        
        parenttraindict[i]=dict_name
    #unique words in entire train group
    
    #total number of words in a class
        another_dict[i]=sum(dict_name.values())
    
        uniquewords_ln=len(uniquewords)
    
    
       
    for key,values in parenttraindict.items():
        den=another_dict[key]+uniquewords_ln
        for k,v in values.items():
            num=v+1
            p=num/den
            values[k]=p
            
    print ("Test Folder starts")
    return parenttraindict,another_dict,uniquewords_ln
    
            
def test_computation(testfolder_path):     
    
    count=0
    totalcount=0
    trainfolder_path=os.path.join("c:", os.sep, "", "") #Enter path of your Train Folder 
    parenttraindict,another_dict,uniquewords_ln=train_computation(os.path.abspath(trainfolder_path))
    testparentdict={}
    testparentdict[0]=parenttraindict
    
    for x,y in testparentdict.items():
        list_testdir = os.listdir(testfolder_path)
        for j,testf in enumerate(list_testdir):
            test_folder=os.path.join(testfolder_path,testf)
            list_test_folderdir = os.listdir(test_folder)
            temp=len(list_test_folderdir)
            totalcount+=temp
            for test_folder_file in list_test_folderdir:
                path_to_file=os.path.join(test_folder,test_folder_file)
                f = open(os.path.abspath(path_to_file), "r")
                s = f.read()
                removeSpecialChars = s.translate ({ord(c): " " for c in "'!@#$%^&*()[]{};:,./<>?\|`~-=_+"})
                wordsxx = removeSpecialChars.split()

                stop_words=set(stopwords.words("english"))

                filtered_sentence=[]
                for w in wordsxx:
                    if w not in stop_words:
                        filtered_sentence.append(w)
                ll = [x for x in filtered_sentence if not re.fullmatch('[' + string.punctuation + ']+', x)]

                no_integers = [x for x in ll if not (x.isdigit() 
                                         or x[0] == '-' and x[1:].isdigit())]

                wordst = [word.lower() for line in no_integers for word in line.split()] 
                line = [i for i in wordst if len(i) > 1]

                finalwords=[]
                for o in line:
                    if o.isalpha():
                        finalwords.append(o)
                    else:
                        line.remove(o)

                f.close()
    #words and their count in each file of each class
                
           
                probfinal={}
               
                for k,v in y.items():
                    c =0.00
                    for singleword in finalwords:
                        if singleword in v:
                            c+=math.log(v[singleword])
                        else:
                            
                            l=another_dict[k]+uniquewords_ln
                            c+=math.log(1/l)
                    c+=math.log(0.05)
                    probfinal[k]=c
               
                maximum = max(probfinal, key=probfinal.get)
                
                if maximum==j:
                    
                    count+=1
                   
           
    
    calc=count/totalcount
    Accuracy=calc*100
    print ("Final Accuracy for correct prediction is %f" % Accuracy)
    
def main():
    
    src_dir=os.path.join("c:", os.sep, "", "")#Enter the Location of your Data Folder
    
    if not os.path.exists(src_dir):
        raise Exception('Directory does not exist ({0}).'.format(src_dir))
    trimfiles(os.path.abspath(src_dir)) #Will trim the files 
    move_files(os.path.abspath(src_dir))#Will create Test and Train Folder
    
    testfolder_path=os.path.join("c:", os.sep, "", "") #Pass the Test Folder path
    test_computation(os.path.abspath(testfolder_path)) #Perform Naive Bayes Computation
if __name__ == '__main__':
    main()

