%'C:\Users\Administrator\Desktop\newfile2\extract1re.txt'
%dlmread('C:\Users\Administrator\Desktop\newfile2\extract2re.txt','\t',6,0);
function datam = readdataWOReClass2(path)
fid1 = fopen(path);
i=1;
[names,values] = textread(path,'%s%f',5);
ncols=values(1);
nrows=values(2);

ex = textread(path,'%n','headerlines',6);
ex2 = reshape(ex,ncols,nrows);
datam = ex2';
n2 = length(unique(datam));
uni2 = unique(datam);
for i = 1:n2
    if(uni2(i)==1)
        %farmland
        datam((datam==uni2(i)))=14;
    elseif(uni2(i)==2)
        %forest
        datam((datam==uni2(i)))=5.5;
        
    elseif(uni2(i)==3)
        %River
        datam((datam==uni2(i)))=26;   
    elseif(uni2(i)==4)
        %Grass Land
        datam((datam==uni2(i)))=33; 
    elseif(uni2(i)==5)
        %Urban land
        datam((datam==uni2(i)))=42;
    elseif(uni2(i)==6)
        %Indus land
        datam((datam==uni2(i)))=58;
    elseif(uni2(i)<0)
        %background color
        datam((datam==uni2(i)))=0;
    end
end

end

