function TransdataP = Transprobs2(transdata,beta2,datam1,Qujian2,types)
ini_state1 = datam1;
maxdistance = max(transdata(:));
tt = unique(ini_state1);
nt = length(types);
[rows,cols] = size(transdata);
dataP = zeros(1,rows*cols);
TransdataP = zeros(nt,rows*cols);
for t = 1:nt
    for i = 1:rows
    for j = 1:cols
        ylab = (j-1)*rows+i;
        if transdata(i,j) > 0 && transdata(i,j) < maxdistance
            dataP(ylab) = (1-1/(1+exp(-1*beta2(t)*transdata(i,j)))); 
        end
    end
    end
    TransdataP(t,:) = dataP;
end
end