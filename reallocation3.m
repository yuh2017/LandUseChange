function [state_trans,unchangedcelln] = reallocation3(state_trans,unchangedcelln,dcells,types)
B = unchangedcelln;
n = length(types);
A = zeros(n,n);
for k1 = n:-1:1
    index2 = dcells(:,end) == types(k1);
    typeicells = dcells(index2,:);
    for k2 = n:-1:1
        %while (unchangedcelln(k1,k2)~=0)
        sortcells = sortrows(typeicells,-k2);
        %length(sortcells)
        transNum2 = unchangedcelln(k1,k2);
        if transNum2 ~= 0 
            numid = length(sortcells(:,1));
            if transNum2 <= numid
                trn = sortcells(1:transNum2,end-2);
                state_trans(trn) = types(k2);
                dcells(trn,end) = types(k2);
                %dcells(sortcells(1:transNum2,n+2),end) = 1;
                nnn = length(sortcells(1:transNum2,n+2));
                %fprintf('total %d can be changed to  %d,and just need %d\n',numid,types(k2),transNum2);
                unchangedcelln(k1,k2) = unchangedcelln(k1,k2) - nnn;
                A(k1,k2) = 0;
            else
                trn=sortcells(1:numid,end-2);
                state_trans(trn) = types(k2);
                dcells(trn,end) = types(k2);
                %dcells(sortcells(1:numid,n+2),end) = 1;
                nnn = length(trn);
                %b = nnn
                unchangedcelln(k1,k2) = unchangedcelln(k1,k2) - nnn;
                A(k1,k2) = transNum2-nnn;
                %continue;
            end
        end
        
        %fprintf('the k2 is %d\n', k2)
        %end
    end
end

% R =B - unchangedcelln;
% 
% if sum(B(:)) ~=0&&sum(R(:))~=0
%     [state_trans,unchangedcelln] = reallocation(state_trans,unchangedcelln,dcells,types);
% end
% unique(unchangedcelln)
%unchangedcelln(1,:)
end