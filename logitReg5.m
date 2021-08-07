function [ probmaps ] = logitReg5(datam1,datam2,fdata)
%UNTITLED3 此处显示有关此函数的摘要
flength = length(fdata);
totaln = unique(datam1);
types = totaln(2:end);
tn = length(types);
probmaps = cell(1,1*tn);
probindes = cell(1,1*tn);
for i = 1:tn
    
    index1 = find(datam1>=0);
    tilength = length(index1);
    xtrain1 = zeros(tilength,flength);
    if ~isempty(index1)
        md3k = datam2;
        md3k1 = datam1;
        indexs0 = index1;
        [a1,b2] = size(md3k);
        md3k2 = zeros(a1,b2);
        for fi = 1:flength
            fxi = fdata{fi};
            aaa = reshape(fxi(index1),1,tilength);
            xtrain1(:,fi) = aaa; 
        end
        
        index2 =  find(md3k==types(i));
        index3 = find(md3k1 == types(i));
        index = setdiff(index2,index3);
        
        md3k2(index) = 1;
        Y = md3k2(index1);
        probindes{i} = indexs0;
        
        nsamples = tilength;

        Y00 = reshape(Y,nsamples,1);
        
        X = xtrain1;
        Y0 = Y00(1:50:end);
        xtrain0 = xtrain1(1:50:end,:); 
        [b,dev,stats] = glmfit(xtrain0,Y0,'binomial','logit');
        [fitprobs,dl,du] = glmval(b,X,'probit',stats);
        ptobset = fitprobs;
        probmaps{i}  = ptobset;
    end
    
end
end

