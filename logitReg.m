function [ betas,betapvalue ] = logitReg(datam1,datam3,roaddist,riverdist,bandist,urbandist)
%UNTITLED3 此处显示有关此函数的摘要
totaln = unique(datam1);
types = totaln(2:end);
tn = length(types);
ids = find(datam1>0);
n = length(ids);
roadd = reshape(roaddist(ids),1,n);
riverd = reshape(riverdist(ids),1,n);
bandd= reshape(bandist(ids),1,n);
urband= reshape(urbandist(ids),1,n);

% ud = reshape(urbandist(ids),1,n);
% sud = reshape(suburbandist(ids),1,n);
%rd = reshape(roaddens(ids),1,n);
% indusd= reshape(indusdist(ids),1,n);
md1 = reshape(datam1(ids),1,n);
md3 = reshape(datam3(ids),1,n);
betacoeffs=zeros(5,1*tn);
betapvalue = zeros(5,1*tn);
for i = 1:tn
    index1 = find(md1(1,:)==types(i));
    if ~isempty(index1)
        md3k = md3(index1);
        md3k2 = md3k;
        roadd1 = roadd(index1);
        %rdens1 = rdens(index1);
        riverd1 = riverd(index1);
        bandd1 = bandd(index1);
        urband1 = urband(index1);
        j = tn;
        cols = i;
        index2 =  md3k==types(j);
        index4 = md3k~=types(j);
        md3k2(index2) = 1;
        md3k2(index4) = 0;
        xtrain = [roadd1;riverd1;bandd1;urband1];
        X = xtrain';
        Y = md3k2';
        [b,dev,stats] = glmfit(X,Y,'binomial','logit');
        betacoeffs(:,cols)  = b;
        betapvalue(:,cols)  = stats.p;
        %[yfit,dl,du] = glmval(b,X,'probit',stats);
        %end
        
%     else
%         types(i)
%         continue;
    end 
end
betas = betacoeffs;
end

