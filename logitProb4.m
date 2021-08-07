function logitSuitability = logitProb4(fdata,logistbetas,state_trans,types)
flength=length(fdata);
ini_state1 = state_trans;
nt = length(types);

[rows,cols] = size(state_trans); 
dataP = zeros(1,rows*cols);
logitSuitability = zeros(nt,rows*cols);
xtrain = zeros(flength,1);
for t = 1:nt
    for i = 1:rows
        for j = 1:cols
            if ini_state1(i,j) ~= 0
                ylab = (j-1)*rows+i;
                index = find(types == ini_state1(i,j));
                mina = (index-1)*nt+1;
                maxb = index*nt;
                mlbetas=logistbetas(:,mina:maxb);
                for fi = 1:flength
                    fxi = fdata{fi};
                    xtrain(fi) = fxi(i,j);
                end
                % mlbetas(:,t)'*xtrain
                if state_trans(i,j) >0
                    [dataP,dl,du] = glmval(mlbetas,xtrain,'probit',betastats);
                    %dataP(ylab) = (1/(1+exp(-1*mlbetas(:,t)'*xtrain)));
                else
                    dataP(ylab) = 0;
                end
            end
        end
    end
    logitSuitability(t,:) = dataP;
end
end