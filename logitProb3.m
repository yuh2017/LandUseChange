function betas = logitProb3(roaddist,riverdist,bandist,urbandist,logistbetas,state_trans,types)
%UNTITLED3 此处显示有关此函数的摘要
totaln = unique(datam1);
types = totaln(2:end);
tn = length(types);
ids = find(datam1~=0);
n = length(ids);
elevdata = reshape(elev(ids),1,n);
slopedata = reshape(slope(ids),1,n);
md1 = reshape(datam1(ids),1,n);
md3 = reshape(datam3(ids),1,n);
betacoeffs=zeros(3,1*tn);
betapvalue = zeros(3,1*tn);
for i = 1:tn
    index1 = find(md1==types(i));
    md3k = md3(index1);
    md3k2 = md3k;
    elevdata1 = elevdata(index1);
    slopedata1 = slopedata(index1);
    j = tn;
    cols = i;
    index2 =  md3k==types(j);
    index4 = md3k~=types(j);
    md3k2(index2) = 1;
    md3k2(index4) = 0;
    xtrain = [elevdata1;slopedata1];
    X = xtrain';
    Y = md3k2';
    [b,dev,stats] = glmfit(X,Y,'binomial','logit');
    betacoeffs(:,cols)  = b;
    betapvalue(:,cols)  = stats.p;
    %[yfit,dl,du] = glmval(b,X,'probit',stats);
end
betas = betacoeffs;
end