clc;

x=input('Enter integer:\n 1 for creating Data and Label Vector\n');
switch (x)
        case 1
           fprintf('Creating Data and Label Vector');

            [Data,gnd]=CreateData();
            
end
Datamat=Data(2:end,:);
[rows col]=size(Datamat);
Labelset=gnd(2:end,:);
[rlabel clabel]=size(unique(Labelset));
Aset=unique(Labelset(:)); 
count=hist(Labelset(:),Aset);
testfold=rows/2;
%TestData=zeros(200,10304);
%TrainData=zeros(200,1); 
index=1;
endcount=0;
endlabelc=0;
for i=1:rlabel 
    a=count(1,i);
    c=a/2;
    
    endlabelc=endlabelc+a;
    if(i==1)
    endcount=endcount+c;
    TestData=Datamat(index:endcount,:);
    TestLabel=Labelset(index:endcount,:);
    TrainData=Datamat((endcount+1):endlabelc,:);
    TrainLabel=Labelset((endcount+1):endlabelc,:);
    else
        index=index+a;
        endcount=endcount+a;
        TestData=vertcat(TestData,Datamat(index:endcount,:));
        TestLabel=vertcat(TestLabel,Labelset(index:endcount,:));
        TrainData=vertcat(TrainData,Datamat((endcount+1):endlabelc,:));
        TrainLabel=vertcat(TrainLabel,Labelset((endcount+1):endlabelc,:));
    end
end
t=input('Enter integer:\n 2 for  SVM Accuracy \n ');
switch (t)
        case 2
           fprintf('Running SVM');

            Result1=LSVM(TrainData,TestData,TrainLabel,TestLabel);
            Result2=LSVM(TestData,TrainData,TestLabel,TrainLabel);

       
end
Accuracy1=Result1*100
Accuracy2=Result2*100
Overall_Accuracy=((Result1+Result2)/2)*100
    
 
    
    