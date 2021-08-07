function [state_trans,unchangedcelln] = reassigncells2(state_trans,unchangedcelln,dcells,types)
B = unchangedcelln;
n = length(types);
A = zeros(1,n);
for k1 = n:-1:1
    index2 = dcells(:,end) == types(k1);
    typeicells = dcells(index2,:);
    
    %while (unchangedcelln(k1,k2)~=0)
    sortcells = sortrows(typeicells,-k1);
    %length(sortcells)
    transNum2 = unchangedcelln(1,k1);
    if transNum2 ~= 0
        numid = length(sortcells(:,1));
        if transNum2 <= numid
            state_trans(sortcells(1:transNum2,end-2)) = types(k1);
            dcells(sortcells(1:transNum2,end-2),end) = types(k1);
            %dcells(sortcells(1:transNum2,n+2),end) = 1;
            nnn = length(sortcells(1:transNum2,n+2));
            %fprintf('total %d can be changed to  %d,and just need %d\n',numid,types(k2),transNum2);
            unchangedcelln(1,k1) = unchangedcelln(1,k1) - nnn;
            A(1,k1) = 0;
        else
            state_trans(sortcells(1:numid,end-2)) = types(k1);
            dcells(sortcells(1:numid,end-2),end) = types(k1);
            %dcells(sortcells(1:numid,n+2),end) = 1;
            nnn = length(sortcells(1:numid,n-1));
            %b = nnn
            unchangedcelln(1,k1) = unchangedcelln(1,k1) - nnn;
            A(1,k1) = transNum2-nnn;
            %continue;
        end
    end
end
end