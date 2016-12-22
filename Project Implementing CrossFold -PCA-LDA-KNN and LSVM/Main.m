clc;
[Data,gnd]=DataCreation();
Datamat=Data(2:end,:);
[rows col]=size(Datamat);
ReducedImageData=imresize(Datamat,[400 2576]);
Labelset=gnd(2:end,:);
[rlabel clabel]=size(unique(Labelset));
MasterData=[Labelset';Datamat'];
MasterReducedData=[Labelset';ReducedImageData'];
y=input('Enter the 1 to execute Task 1\n Enter the 2 to execute Task 2\n Enter the 3 to execute Task 3\n Enter the 4 to execute Task 4\n Enter the 5 to execute Task 5\n Enter the 6 to execute Task 6\n');
switch (y)
    case 1
        [OutputAccuracy]=Task1(MasterData,Labelset,1);
        disp(sprintf('Overall Accuracy of PCA in Task 1 : %0.5g',OutputAccuracy));
        fprintf(1, '\n');
    case 2
        [OutputAccuracy]=Task1(MasterReducedData,Labelset,2);
        disp(sprintf('Overall Accuracy of PCA on Resized image in Task 2 : %0.5g',OutputAccuracy));
        fprintf(1, '\n');
    case 3
        [OutputAccuracy]=Task1(MasterData,Labelset,3);
        disp(sprintf('Overall Accuracy of LDA in Task 3 : %0.5g',OutputAccuracy));
        fprintf(1, '\n');
    case 4
        [OutputAccuracy]=Task1(MasterData,Labelset,4);
        disp(sprintf('Overall Accuracy of PCA and then LDA in Task 4 : %0.5g',OutputAccuracy));
        fprintf(1, '\n');
    case 5
        [OutputAccuracy]=Task1(MasterData,Labelset,5);
        disp(sprintf('Overall Accuracy of LSVM on crossvalidation in Task 5 : %0.5g',OutputAccuracy));
        fprintf(1, '\n');
    case 6
        [OutputAccuracy]=Task1(MasterData,Labelset,6);
        disp(sprintf('Overall Accuracy of LSVM on PCA data in Task 6 : %0.5g',OutputAccuracy));
        fprintf(1, '\n');
end