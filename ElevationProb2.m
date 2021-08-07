function ConstructSuitability = ElevationProb3(ElevData,SlopeData,betasSuit,state_trans,types)
nt = length(types);
[rows,cols] = size(ElevData); 
dataP = zeros(1,rows*cols);
ConstructSuitability = zeros(nt,rows*cols);
for t = 1:nt
    for i = 1:rows
        for j = 1:cols
            if state_trans(i,j)> 0
                ylab = (j-1)*rows+i;
                index = find(types == state_trans(i,j));
                mina = index;%-1)*nt+1;
                %maxb = index*nt;
                mlbetas=betasSuit(:,mina);
                xtrain = [1;ElevData(i,j);SlopeData(i,j)];
                if t==index
                    dataP(ylab) = 1-(1/(1+exp(-1*mlbetas'*xtrain)));
                elseif t == nt
                    dataP(ylab) = (1/(1+exp(-1*mlbetas'*xtrain)));
                else
                    dataP(ylab) = 0;
                end
            end
        end
    end
    ConstructSuitability(t,:) = dataP;
end
end