function [state_trans,chengedcelln,unchangedcelln] = Assigncells(state_trans,dcells,Gconfusion_m,types,iiyear,Qujian2)
n = length(types);
dbn = unique(Qujian2);
for ith = 2:length(dbn)   
    district_i = Gconfusion_m{ith-1};
    b = district_i(iiyear,:);
    A = reshape(b,n,n);
    dN = A;
    transNC = sum(dN);
    unchangedcelln = zeros(1,n);
    chengedcelln = zeros(1,n);
    ylabs = dcells(:,n+3)==dbn(ith);
    reindex = ylabs;
    typeicells = dcells(reindex,:);
    transferindex = typeicells(:,end-2);
%         for ij = 1:length(typeicells(:,1))
%             if (typeicells(ij,k1) == typeicells(ij,n+1))
%                 dlength = dlength +1;
%                 transferindex = [transferindex ,typeicells(ij,end-2)];
%             end
%         end
     for k1 = n:-1:1  
        transNum = transNC(k1);
        translength = length(transferindex);
        if  translength>= transNum
            sorttransferindex = sortrows(dcells(transferindex,:),-k1);
            %length(sorttransferindex(1:transNum,n+2))
            state_trans(sorttransferindex(1:transNum,n+2)) = types(k1);
            dcells(sorttransferindex(1:transNum,n+2),end) = types(k1);
            dcells(sorttransferindex(transNum+1:end,n+2),(1:n+1)) = 0;
            aaa = max(dcells(sorttransferindex(transNum+1:end,n+2),1:n)');
            dcells(sorttransferindex(transNum+1:end,n+2),n+1) = aaa';
            nnn = length(dcells(sorttransferindex(1:transNum,n+2),end-1));
            %fprintf('changed transNum to %d is %d\n', types(k2),nnn);
            transferindex = sorttransferindex(transNum+1:end,n+2);
        else
            fprintf('Wrong! %d year allocation\n',ith-2);
%             state_trans(transferindex) = types(k1);
%             dcells(transferindex,end) = types(k1);
%             %dcells(transferindex,end) = 1;
%             nnn= length(transferindex);
%             %fprintf('changed transferindex to %d is %d\n',types(k2), nnn);
%             transferindex2 = transferindex;
         end
%             unchangedcelln(1,k1) = transNum - nnn;
%             chengedcelln(1,k1) = nnn;
%             %dcells(reindex,end) = 0;
%             %fprintf('the reindex is %d\n', length(reindex));
%         
%         currentcellsn(k1) = length(find(dcells(:,end-2) == types(k1)));
     end
%     % newtransNum = sum(unchangedcelln) - sum(unchangedcelln(1:n),2);
%     if sum(unchangedcelln(:) ~= 0)
%         [state_trans,unchangedcelln] =
%         reassigncells2(state_trans,unchangedcelln,dcells,types);
%     %fprintf('finish %d zone allocation\n',ith-2);
end
end
