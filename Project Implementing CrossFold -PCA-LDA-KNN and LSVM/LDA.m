function [NewTrainData,NewTestData]=LDA(TrainData,TestData)
             TrainLabel=TrainData(1,:);
             TrainmodData=TrainData(2:end,:);
             [rowtrain,coltrain] = size(TrainmodData');
             TestLabel=TestData(1,:);
             TestmodData=TestData(2:end,:);
             [rowtest,coltest] = size(TestmodData');
             uniquetrainlabels=unique(TrainLabel(:)); 
             sizeuniquetrainlabels=size(uniquetrainlabels,1);
             totaltrainlabels=size(TrainLabel,2);
             
             FinalScattermat=zeros(size(TrainmodData,1),size(TrainmodData,1));
             Finalbetweenclassmat=zeros(size(TrainmodData,1),size(TrainmodData,1));
             for iterlabel=1:sizeuniquetrainlabels
                 countelements=sum(TrainLabel(:) == iterlabel);
                 newclass=zeros(coltrain,1);
                 for itertrain=1:totaltrainlabels
                   if TrainLabel(1,itertrain)==iterlabel
                      if itertrain==1 && iterlabel==1
                          newclass=TrainmodData(:,1);
                      end
                      newclass=[newclass TrainmodData(:,itertrain)];
                   end
                 end
                 newclass=newclass(:,2:end);
                 noofelements=countelements-1;
                 Scattermat=noofelements*cov(newclass');
                 FinalScattermat=FinalScattermat+Scattermat;
             end
             meantrain = mean(TrainmodData',1);
             normtraindata = TrainmodData' - repmat(meantrain,rowtrain,1);
             
             St=cov(normtraindata);
             Finalbetweenclassmat=St-FinalScattermat;
             invFinalScattermat=pinv(FinalScattermat);
             invFinalbetweenclassmat=invFinalScattermat*Finalbetweenclassmat;
             totallabels=sizeuniquetrainlabels-1;
             [V,D]=eigs(invFinalbetweenclassmat,totallabels);
             
            
             %figure;
             %title('LDA Graph');
             %plot(D)
             %set(gca,'XTick',[0:50:10304])
             NewTrainData=V'*TrainmodData;
             NewTestData=V'*TestmodData;
             NewTrainData=vertcat(TrainLabel,NewTrainData);
             NewTestData=vertcat(TestLabel,NewTestData);

end