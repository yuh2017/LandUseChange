function landsuitdata = readlandsuitabilityWReclass(suitdata,betasSuit,datam1,types)
ini_state1 = datam1;
maxdens = max(suitdata(:));
tt = unique(ini_state1);
nt = length(types);
[rows,cols] = size(suitdata);
dataP = zeros(1,rows*cols);
landsuitdata = zeros(nt,rows*cols);
for t = 1:nt
    for i = 1:rows
        for j = 1:cols
            ylab = (j-1)*rows+i;
            if datam1(i,j) >0
                if t >=3
                    dataP(ylab) = (1/(1+exp(-1*betasSuit(t)*suitdata(i,j))));
                else
                    dataP(ylab) = (1-1/(1+exp(-1*betasSuit(t)*suitdata(i,j))));
            end
        end
    end
    landsuitdata(t,:) = dataP;
end
end