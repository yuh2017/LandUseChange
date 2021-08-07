function [state_trans] = cellTransformation2(state_trans,dcells,Gconfusion_m,types,iiii)
n = length(types);
district_i = Gconfusion_m;
b = district_i(iiii,:);
A = reshape(b,n,n);
dN = A;
%dN(n,:) = 0;
unchangedcelln = zeros(n,n);
chengedcelln = zeros(n,n);
ylabs02 = find(dcells(:,end)==0);
ylabs = ylabs02;
%k1 = n:-1:1
for k1 = 1:n
    indexk1 = find(dcells(:,end-1) == types(k1));
    index1 = intersect(ylabs ,indexk1);
    reindex = index1;
    typeicells = dcells(reindex,:);
    %k2 = n:-1:1
    for k2 = 1:n
        transNum = dN(k1,k2);
        dlength = 0;
        transferindex = [];
        for ij = 1:length(typeicells(:,1))
            if (typeicells(ij,k2) == typeicells(ij,n+1))
                dlength = dlength +1;
                %typeicells(ij,:)
                transferindex = [transferindex ,typeicells(ij,n+2)];
            end
        end
        translength = length(transferindex);
        if  translength>= transNum
            sorttransferindex = sortrows(dcells(transferindex,:),-(n+1));
            %length(sorttransferindex(1:transNum,n+2))
            state_trans(dcells(sorttransferindex(1:transNum,n+2),end-3)) = types(k2);
            dcells(sorttransferindex(1:transNum,n+2),end-1) = types(k2);
            dcells(sorttransferindex(transNum+1:end,n+2),k2) = 0;
            dcells(sorttransferindex(transNum+1:end,n+2),end) = 1;
            aaa = max(dcells(sorttransferindex(transNum+1:end,n+2),1:n)');
            dcells(sorttransferindex(transNum+1:end,n+2),n+1) = aaa';
            nnn = length(dcells(sorttransferindex(1:transNum,n+2),end-2));
            %fprintf('changed transNum to %d is %d\n', types(k2),nnn);
            transferindex2 = sorttransferindex(1:transNum,n+2);
        else
            state_trans(transferindex) = types(k2);
            dcells(transferindex,end-1) = types(k2);
            dcells(transferindex,k2) = 0;
            dcells(transferindex,end) = 1;
            nnn= length(transferindex);
            %fprintf('changed transferindex to %d is %d\n',types(k2), nnn);
            transferindex2 = transferindex;
        end
        unchangedcelln(k1,k2) = transNum - nnn;
        chengedcelln(k1,k2) = nnn;
        reindex = setdiff(typeicells(:,end-3),transferindex2);
        %dcells(reindex,end) = 0;
        %fprintf('the reindex is %d\n', length(reindex));
    end
end
% newtransNum = sum(unchangedcelln) - sum(unchangedcelln(1:n),2);
if sum(unchangedcelln(:) ~= 0)
    [state_trans,unchangedcelln] = reallocation2(state_trans,unchangedcelln,dcells,types);
end
%fprintf('finish %d zone allocation\n',ith-2);

end
