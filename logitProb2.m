function logitSuitability = logitProb2(roaddist,riverdist,bandist,urbandist,logistbetas,state_trans,types)
ini_state1 = state_trans;
nt = length(types);
[rows,cols] = size(roaddist); 
dataP = zeros(1,rows*cols);
logitSuitability = zeros(nt,rows*cols);
for t = 1:nt
    for i = 1:rows
        for j = 1:cols
            if ini_state1(i,j) > 0
                ylab = (j-1)*rows+i;
                index = find(types == ini_state1(i,j));
                mina = index;
%                 maxb = index*nt;
                %size(logistbetas)
                mlbetas=logistbetas(:,mina);
                xtrain = [1;roaddist(i,j);riverdist(i,j);bandist(i,j);urbandist(i,j)];
                %urbandist(i,j);suburbandist(i,j);indusdist(i,j);;roaddens(i,j)
                % mlbetas(:,t)'*xtrain
                if t == index
                    dataP(ylab)=0.7;
                elseif t == nt
                    dataP(ylab) = (1/(1+exp(-1*mlbetas'*xtrain)));
                else
                    dataP(ylab) = 0;
                end
            end
        end
    end
    logitSuitability(t,:) = dataP;
end
end