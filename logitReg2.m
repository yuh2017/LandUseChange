function [betas] = logitReg2(datam1,datam3,tansdist,urbandist,suburbandist,roaddens,boundries )
%logitReg FUNCTION
types = unique(datam1);
tn = length(types);
bdcode = unique(boundries(:));
betas = cell(5);
length(bdcode)
for k = 2: 2
    boundaryID = boundries == bdcode(k);
    ids = find(datam1(boundaryID)~=0);
    n = length(ids);
    td = reshape(tansdist(ids),1,n);
    ud = reshape(urbandist(ids),1,n);
    sud = reshape(suburbandist(ids),1,n);
    rd = reshape(roaddens(ids),1,n);
    md1 = reshape(datam1(ids),1,n);
    md3 = reshape(datam3(ids),1,n);
    betacoeffs=zeros(4,tn*tn);
    betapvalue = zeros(4,tn*tn);
    for i = 1:tn
        index1 = find(md1==types(i));
        md3k = md3(index1);
        md3k2 = md3k;
        td1 = td(index1);
        ud1 = ud(index1);
        sud1 = sud(index1);
        rd1 = rd(index1);
        for j = 1:tn
            cols = (i-1)*tn+j;
            index2 =  md3k==types(j);
            index4 = md3k~=types(j);
            md3k2(index2) = 1;
            md3k2(index4) = 0;
            xtrain = [td1;sud1;rd1];
            X = xtrain';
            Y = md3k2';
            [b,dev,stats] = glmfit(X,Y,'binomial','logit');
            betacoeffs(:,cols)  = b;
            betapvalue(:,cols)  = stats.p;
            [yfit,dl,du] = glmval(b,X,'probit',stats);
        end
    end
    betas(k)={betacoeffs};
end

% figure(10)
% % scatter(X(idx,4), Y(idx),'o');
% % hold on
% scatter(X(idx,4),yfit,'.','k');
% hold on 
% scatter(X(idx,4),Y(idx),'.','r');
% idx1 = find( yfit >0.5);
% idx2 = find( yfit <0.5);
% yfit2 = yfit;
% yfit2(idx1) = 1;
% yfit2(idx2) = 0;
% dy = Y(idx) - yfit2;
% idx3 = find(dy==0);
% length(idx3)/length(dy)
end

