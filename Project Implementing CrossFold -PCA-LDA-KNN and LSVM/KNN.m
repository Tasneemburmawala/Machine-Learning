function output= KNN(TrainData,TestData,K)
%KNN Code Starts
     

     class=unique(TrainData(1,:));
     
     classsize=size(class);
     datasizee=size(TrainData);
     TrainDataing=datasizee(2)/classsize(2);

     Data=TrainData(2:datasizee(1),1:datasizee(2));
     TestDatasize=size(TestData);
     Result=zeros(1,TestDatasize(2));
        for x=1:TestDatasize(2)
            clear temp;
            temp=(Data-repmat(TestData(2:end,x),1,datasizee(2))).^2;
            tempsum=sum(temp,1);
            tempsum=tempsum.^(1/2);
            class(1,:)=1;    
            sortmat=sort(tempsum);
            tempsize=size(sortmat);
            maxarr=tempsum(tempsize(2));
            for y=1:K
                clear sortmat;
                min=sort(tempsum);
                minindex=find(tempsum==min(1));
                class(ceil(minindex(1)/TrainDataing))=class(ceil(minindex(1)/TrainDataing))+1;
                tempsum(minindex(1))=maxarr(1)+y;
            end
        clear max
        classindex=find(class==max(class));
        Result(1,x)=classindex(1);
        end
output=Result;
end