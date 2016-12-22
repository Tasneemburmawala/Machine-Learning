
function output=LSVM(TrData,TeData,TrLabel,TeLabel)
testdata=TeData;
[testrows testcol]=size(testdata);
x=TrData;
[trainrows traincol]=size(x);
[trlabelrow trlabelcol]=size(unique(TrLabel));
labeltraincount=trlabelrow;
z=zeros(trainrows,1);
f=-ones(trainrows,1);
A=-eye(trainrows);
b=zeros(trainrows,1);
B=zeros(trainrows,trainrows);
a=zeros(trainrows,1);
lb=zeros(trainrows,1);
mat(1,1)=[100];
ub=repmat(mat,trainrows,1);

FinalW=zeros(labeltraincount,traincol);
Finalb=zeros(labeltraincount,1);
format short;
temp=0;
for i=1:labeltraincount
    temp=temp+;
        for j=1:trainrows
            if(TrLabel(j)==i)
                z(j,1)=1;
            else
                z(j,1)=-1;
            end
        end
        
        B(1,:)=z';
        
        H=(x*x').*(z*z');
        
        alpha=quadprog(H+eye(200)*0.001,f,A,a,B,b,lb,ub);
        wa=(alpha.*z)';
        w=wa*x;
        wzero=(1/z(temp,1))-(w*x(temp,:)');
        if(i==1)
            FinalW=w;
            Finalb=wzero;
           
        else
            FinalW=vertcat(FinalW,w);
            Finalb=vertcat(Finalb,wzero);
        end
        
end

predictedLabel=zeros(testrows,1);
[telabelrow telabelcol]=size(unique(TeLabel));

labeltestcount=telabelrow;
for i=1:testrows
    maxval=zeros(labeltestcount,1);
    
    for j=1:labeltestcount
        gx=FinalW(j,:)*testdata(i,:)'+Finalb(j,1);
        maxval(j,1)=gx;
    end
    [M,labelj] = max(maxval);
    
    predictedLabel(i,1)=labelj;
   
end
countr=0;
for i=1:testrows
    if(TeLabel(i,1)==predictedLabel(i,1))
        countr=countr+1;
    end
end

Accuracy=(countr/200);
    

       
Result=Accuracy;
output=Result;
end