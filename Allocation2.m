function [state_trans,chengedcelln,unchangedcelln] = Allocation2(state_trans,dcells,Gconfusion_m,types,i,Qujian2)

n = length(types);
% dcells(:,di) = [];
% fixM(di,:) = [];
% fixM(:,di) = [];
% %dcells(all(dcells == 0,2),:) = [];
A = reshape(randAM(i,:),n,n);
% A(di,:) = [];
% A(:,di) = [];
dN = fixM + A;
unchangedcelln = zeros(n,n);
chengedcelln = zeros(n,n);
currentcellsn = zeros(1,n);
for k1 = n:-1:1
    %types(k1)
%     a1 = length(find(initialstates == types(k1)))
%     a2 = length(find(dcells(:,end) == types(k1)))
    index1 = find(dcells(:,end) == types(k1));
%     a = types(k1)
%     length(index1)
    reindex = index1;
    for k2 = n:-1:1
        typeicells = dcells(reindex,:);
        transNum = dN(k1,k2);
        %[maxi,typeindex] = max(typeicells(:,1:n),[],2);
        dlength = 0;
        transferindex = [];
        for i = 1:length(typeicells(:,1))
            if (typeicells(i,k2) == typeicells(i,n+1))
                dlength = dlength +1;
                transferindex = [transferindex ,typeicells(i,end-1)];
            end
        end
        translength = length(transferindex);
        if  translength>= transNum
%             randsort = randperm(translength);
%             randselect = randsort(1:transNum);
%             SelectIndex = transferindex(randselect);
            sorttransferindex = sortrows(dcells(transferindex,:),-(n+1));
            %length(sorttransferindex(1:transNum,n+2))
            state_trans(dcells(sorttransferindex(1:transNum,n+2),end-1)) = types(k2);
            dcells(sorttransferindex(1:transNum,n+2),end) = types(k2);
            %dcells(sorttransferindex(1:transNum,n+2),end) = 1;
            %state_trans(sorttransferindex(1:transNum,end)) = types(k2);
%             dcells(sorttransferindex(:,end-1),k2) = 0;
%             max(dcells(sorttransferindex(:,end-1),1:n),[],2)
%             dcells(sorttransferindex(:,end-1),n+1) = max(dcells(sorttransferindex(:,end-1),1:n),[],2);
            nnn = length(dcells(sorttransferindex(1:transNum,n+2),end-1));
            %fprintf('changed transNum to %d is %d\n', types(k2),nnn);
            transferindex2 = dcells(sorttransferindex(1:transNum,n+2),end-1);
        else
            state_trans(transferindex) = types(k2);
            dcells(transferindex,end) = types(k2);
            %dcells(transferindex,end) = 1;
            nnn= length(transferindex);
            %fprintf('changed transferindex to %d is %d\n',types(k2), nnn);
            transferindex2 = transferindex;
        end
        unchangedcelln(k1,k2) = transNum - nnn;
        chengedcelln(k1,k2) = nnn;
        reindex = setdiff(typeicells(:,end-1),transferindex2);
        %dcells(reindex,end) = 0;
        %fprintf('the reindex is %d\n', length(reindex));
    end
    currentcellsn(k1) = length(find(dcells(:,end-1) == types(k1)));
end
% newtransNum = sum(unchangedcelln) - sum(unchangedcelln(1:n),2);
if sum(unchangedcelln(:) ~= 0)
    [state_trans,unchangedcelln] = reallocation2(state_trans,unchangedcelln,dcells,types);
end

% if sum(unchangedcelln(:)) ~= 0
%     disp(unchangedcelln);
% end
% chengedcelln
% state_trans = reallocation(state_trans,reindex,reNum);
%size(sortcells)
%transIndex1 = sortcells(1:transNum,k2);    
end
