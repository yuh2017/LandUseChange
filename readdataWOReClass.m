%'C:\Users\Administrator\Desktop\newfile2\extract1re.txt'
%dlmread('C:\Users\Administrator\Desktop\newfile2\extract2re.txt','\t',6,0);
function datam = readdataWOReClass(path)
fid1 = fopen(path);
i=1;
ncols =10;
nrows = 10;
while ~feof(fid1)
    aline=fgetl(fid1);
    splitstr = regexp(aline,' ', 'split');
    len = length(splitstr);
    if len <100
        if strcmp(splitstr(1),'ncols')   
            ncols = str2double(splitstr(end));
        elseif strcmp(splitstr(1),'nrows')
            nrows = str2double(splitstr(end));
        end
        datam = zeros(nrows,ncols);
        datam(:) = -9999;
    else
        break
    end
end
while ~feof(fid1)
    aline=fgetl(fid1);
    splitstr = regexp(aline,' ', 'split');
    len = length(splitstr);
    if len>100
        %sum(~~str2double(splitstr(1:l)))
        l = ncols;
        linedata = str2double(splitstr(1:l));
        datam(i,:) = linedata;
        i=i+1;
    end
end
fclose(fid1);
n2 = length(unique(datam));
uni2 = unique(datam);
for i = 1:n2
    uni2(i)
    length(find(datam==uni2(i)))
    if(uni2(i)==1)
        %farmland
        datam((datam==uni2(i)))=14;
    elseif(uni2(i)==2)
        %forest
        datam((datam==uni2(i)))=42;%5.5;
        
    elseif(uni2(i)==3)
        %River
        datam((datam==uni2(i)))=33;%26;   
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

