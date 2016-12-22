function [OutputAccuracy]= Task1(MasterData,Labelset,y)
classlabel=unique(MasterData(1,:));
datasize=size(MasterData);
classsize=size(classlabel);
Aset=unique(Labelset(:)); 
count=hist(Labelset(:),Aset);
%disp(count)
totsameimg=count(1,1);
crossValidationFolds=5;
difference=totsameimg;
startpoint=0;
FinalAccuracy=0;

for i=1:crossValidationFolds
           accuracy=0;
            numberOfRowsPerFold=ceil(difference/(crossValidationFolds+1-i));
            difference=difference-numberOfRowsPerFold;
            temparr=zeros(1,datasize(2));
            for j=1:classsize(2)
                startOfCol=startpoint+((j-1)*totsameimg)+1;
                EndOfCol=startpoint+((j-1)*totsameimg)+numberOfRowsPerFold;
                temparr(1,startOfCol:EndOfCol)=1;
            end 
            %Creating current fold Test Data and Train Data
            idxtest=find(temparr==1);
            idxtrain=find(temparr==0);
            TestData=MasterData(:,idxtest);
            TrainData=MasterData(:,idxtrain);
            startpoint=startpoint+numberOfRowsPerFold;
            TeLabel=TestData(1,:);
            TrLabel=TrainData(1,:);
            TeData=TestData(2:end,:);
            TrData=TrainData(2:end,:);
            
                %Task1
                if y==1 || y==2
                    if i==1 && y==1
                      fprintf('Executing Task 1 \n');
                    elseif i==1 && y==2
                        fprintf('Executing Task 2 \n');
                    end
                    [PCATrainData,PCATestData]=PCA(TrainData,TestData,80);
                    KNNPCAResult=KNN(PCATrainData,PCATestData,1);
                    accuracy=100*numel(find(TeLabel==KNNPCAResult))/numel(TeLabel);
                    disp(sprintf('Classfold Number : %d',i));
                    disp(sprintf('Accuracy of PCA  : %0.5g',accuracy));
                    fprintf(1, '\n');
                    FinalAccuracy=FinalAccuracy+accuracy;
                 
                elseif y==3
                     %Task 3
                      if i==1
                        fprintf('Executing Task 3 \n');
                      end
                      [LDATrainData,LDATestData]=LDA(TrainData,TestData);
                      KNNLDAResult=KNN(LDATrainData,LDATestData,1);
                      accuracy=100*numel(find(TeLabel==KNNLDAResult))/numel(TeLabel);
                      disp(sprintf('Classfold Number : %d',i));
                      disp(sprintf('Accuracy of LDA in Task 3 : %0.5g',accuracy));
                      fprintf(1, '\n');
                      FinalAccuracy=FinalAccuracy+accuracy;
                elseif y==4
                     %Task 4
                     if i==1
                       fprintf('Executing Task 4 \n');
                     end
                     [PCATrainData,PCATestData]=PCA(TrainData,TestData,320);
                     [PCALDATrainData,PCALDATestData]=Task4(PCATrainData,PCATestData);
                      PCALDAResult=KNN(PCALDATrainData,PCALDATestData,1);
                      accuracy=100*numel(find(TeLabel==PCALDAResult))/numel(TeLabel);
                      disp(sprintf('Classfold Number : %d',i));
                      disp(sprintf('Accuracy of PCA and then LDA in Task 4 : %0.5g',accuracy));
                      fprintf(1, '\n');
                      FinalAccuracy=FinalAccuracy+accuracy;
                elseif y==5
                    %Task5
                    if i==1
                       fprintf('Executing Task 5 \n');
                    end
                    LSVMResult=LSVM(TrData',TeData',TrLabel',TeLabel');
                    accuracy=LSVMResult*100;
                    disp(sprintf('Classfold Number : %d',i));
                    disp(sprintf('Accuracy of LSVM in Task 5 : %0.5g',accuracy));
                    fprintf(1, '\n');
                    FinalAccuracy=FinalAccuracy+accuracy;
                else y==6
                    %Task 6
                    if i==1
                      fprintf('Executing Task 6 \n');
                    end
                    [PCATrainData,PCATestData]=PCA(TrainData,TestData,80);
                    PCATrData=PCATrainData(2:end,:);
                    PCATeData=PCATestData(2:end,:);
                    PCATrLabel=PCATrainData(1,:);
                    PCATeLabel=PCATestData(1,:);
                    PCALSVMResult=LSVM(PCATrData',PCATeData',PCATrLabel',PCATeLabel');
                    accuracy=PCALSVMResult*100;
                    disp(sprintf('Classfold Number : %d',i));
                    disp(sprintf('Accuracy of LSVM with PCA in Task 6 : %0.5g',accuracy));
                    fprintf(1, '\n');
                    FinalAccuracy=FinalAccuracy+accuracy;
            
           
            end
end
FinalAccuracy=FinalAccuracy/5;
OutputAccuracy=FinalAccuracy;
end
