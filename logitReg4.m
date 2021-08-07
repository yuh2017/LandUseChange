function [ probmaps,probindes ] = logitReg4(datam1,datam2,fdata)
%UNTITLED3 此处显示有关此函数的摘要
flength = length(fdata);
totaln = unique(datam1);
types = totaln(2:end);
tn = length(types);
probmaps = cell(1,1*tn);
probindes = cell(1,1*tn);
for i = 1:tn
    index1 = find(datam1==types(i));
    tilength = length(index1);
    xtrain1 = zeros(tilength,flength);
    if ~isempty(index1)
        md3k = datam2(index1);
        md3k1 = datam1(index1);
        indexs0 = index1;
        [a1,b2] = size(md3k);
        md3k2 = zeros(a1,b2);
        for fi = 1:flength
            fxi = fdata{fi};
            aaa = reshape(fxi(index1),1,tilength);
            xtrain1(:,fi) = aaa; 
        end
        for j = tn:tn
            cols = (i-1)*tn+j;
            index2 =  find(md3k==types(j));
            index3 = find(md3k1 == types(j));
            index = setdiff(index2,index3);
            index4 = md3k~=types(j);
            md3k2(index) = 1;
            probindes{i} = indexs0;
            
            X = xtrain1;
            Y = md3k2;
            [b,dev,stats] = glmfit(X,Y,'binomial','logit');
            [fitprobs,dl,du] = glmval(b,X,'probit',stats);
            probmaps{i}  = fitprobs;
        end
    end
    
end
end

