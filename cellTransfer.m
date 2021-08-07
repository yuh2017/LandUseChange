function [state_trans,transferprobs1] = cellTransfer2(state_trans,dcells,Gconfusion_m,types,iiii,Qujian2)
n = length(types);
dbn = unique(Qujian2);
for ith = 2:length(dbn)   
    district_i = Gconfusion_m{ith-1};
    b = district_i(iiii,:);
    A = reshape(b,n,n);
    dNm = A;
    dN = sum(dNm);
    ylabs01 = find(dcells(:,1+3)==dbn(ith));
    ylabs02 = find(dcells(:,end)==0);
    ylabs = intersect(ylabs01 ,ylabs02);
    k1 = n;
    transNum = dN(k1)-dNm(k1,k1);
    indexk1 = find(state_trans ~=types(k1));
    index1 = intersect(ylabs ,indexk1);
    transferindex = index1;
    translength = length(transferindex);
    if  translength>= transNum
        sorttransferindex = sortrows(dcells(transferindex,:),-1);
        %length(sorttransferindex(1:transNum,n+2))
        min(dcells(sorttransferindex(1:transNum,1+2),1) )
        max(dcells(sorttransferindex(1:transNum,1+2),1) )
        state_trans(sorttransferindex(1:transNum,1+2)) = types(end);
        dcells(sorttransferindex(1:transNum,1+2),end-1) = types(end);
        %dcells(sorttransferindex(transNum+1:end,1+2),1) = 0;
        dcells(sorttransferindex(1:transNum,1+2),end) = 1;
        %             aaa = max(dcells(sorttransferindex(transNum+1:end,1+2),1:n)');
        %             dcells(sorttransferindex(transNum+1:end,1+2),1+1) = aaa';
        %fprintf('changed transNum to %d is %d\n', types(k2),nnn);
    else
        state_trans(transferindex) = types(end);
        dcells(transferindex,end-1) = types(end);
        dcells(transferindex,end) = 1;
        %dcells(transferindex,end) = 1;
        
        %fprintf('changed transferindex to %d is %d\n',types(k2), nnn);
        
    end
    
    %             reindex = setdiff(typeicells(:,end-3),transferindex2);
    %dcells(reindex,end) = 0;
    %fprintf('the reindex is %d\n', length(reindex));
  
    transferprobs1 = dcells;
end
end
