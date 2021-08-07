%'C:\Users\Administrator\Desktop\newfile2\extract1re.txt'
%dlmread('C:\Users\Administrator\Desktop\newfile2\extract2re.txt','\t',6,0);
function datam = readTransdata2(path)
fid1 = fopen(path);
i=1;
ncols =10;
nrows = 10;
while ~feof(fid1)
    aline=fgetl(fid1);
    splitstr = regexp(aline,' ', 'split');
    len = length(splitstr);
    if len <52
        if strcmp(splitstr(1),'ncols')   
            ncols = str2double(splitstr(end));
        elseif strcmp(splitstr(1),'nrows')
            nrows = str2double(splitstr(end));
        end
        datam = zeros(nrows,ncols);
    else
        break
    end
end

while ~feof(fid1)
    aline=fgetl(fid1);
    splitstr = regexp(aline,' ', 'split');
    len = length(splitstr);
    if len>52
        %sum(~~str2double(splitstr(1:l)))
        l = ncols;
        linedata = str2double(splitstr(1:l));
        datam(i,:) = linedata;
        i=i+1;
    end
end
fclose(fid1);
end

