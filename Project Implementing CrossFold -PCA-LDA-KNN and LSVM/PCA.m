function [NewTrainData,NewTestData]=PCA(TrainData,TestData,k)
             TrainLabel=TrainData(1,:);
             TrainmodData=TrainData(2:end,:);
             [rowtrain,coltrain] = size(TrainmodData');
             TestLabel=TestData(1,:);
             TestmodData=TestData(2:end,:);
             [rowtest,coltest] = size(TestmodData');
             % subtract off the mean for each dimension
             meantrain = mean(TrainmodData',1);
             normtraindata = TrainmodData' - repmat(meantrain,rowtrain,1);
             normtestdata = TestmodData' - repmat(meantrain,rowtest,1); 

             traincov=normtraindata'*normtraindata;
             % find the eigenvectors and eigenvalues
             [egvectrain, egvaltrain] = eig(traincov);
             %figure;
             %title('PCA Graph');
             %plot(egvaltrain)
             %set(gca,'XTick',[0:50:10304]);
            
             egvaltrain=diag(egvaltrain);
             [egtrainval, egtrainindices] = sort(egvaltrain,'descend');
              
             egvectrain=egvectrain(:,egtrainindices(1:k)); 
             NewTrainData=egvectrain'*normtraindata';
             NewTestData=egvectrain'*normtestdata';
             NewTrainData=vertcat(TrainLabel,NewTrainData);
             NewTestData=vertcat(TestLabel,NewTestData);
end
            
              