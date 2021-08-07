%'C:\Users\Administrator\Desktop\newfile2\extract1re.txt'
%dlmread('C:\Users\Administrator\Desktop\newfile2\extract2re.txt','\t',6,0);
function datam = readfeatures(path)
fid1 = fopen(path);
i=1;
[names,values] = textread(path,'%s%f',5);
ncols=values(1);
nrows=values(2);
ex = textread(path,'%n','headerlines',6);
ex2 = reshape(ex,ncols,nrows);
datam = ex2';
end

