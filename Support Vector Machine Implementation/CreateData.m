function [Data,gnd]=CreateData()
clear;
clc;

Data=zeros(1,10304);
gnd=zeros(1,1);
listfolders=dir('C:'); %#Enter the location of the Data folder
dirIndex = [listfolders.isdir];
 fileList = {listfolders(~dirIndex).name}';  %'# Get a list of the files
  if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(listfolders,x),...  %# Prepend path to files
                       fileList,'UniformOutput',false);
  end
 

    subDirs = {listfolders(dirIndex).name;};  %# Get a list of the subdirectories
    sortedCellArray = natsortfiles(subDirs(1,3:end));
    validIndex = ~ismember(subDirs,{'.','..'});
    %liste=listfolders(i).name;
    for iDir = 1:40
    subfolder=fullfile('C:',sortedCellArray{iDir}); %#Enter the location of the Data Folder
    sublistfolders=dir(subfolder);
    dirsubIndex = [sublistfolders.isdir];
    subsubDirs = {sublistfolders(~dirsubIndex).name;};  %# Get a list of the subdirectories
    sortedsubCellArray = natsortfiles(subsubDirs(1,1:end));
    for j=1:10
        
        subimgfolder=fullfile(subfolder,sortedsubCellArray{j}); 
        %disp(subimgfolder)
        A=imread(subimgfolder);
        A2=im2double(A);
        ImgVector = A2(:);
        if (i==1 && j==1)
        Data=ImgVector';
        gnd=iDir;
        else
            Data=vertcat(Data,ImgVector');
            gnd=vertcat(gnd,iDir);
        end
        
    end
    
    end
 Data=Data;
 gnd=gnd;
end
