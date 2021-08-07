function [kappavector ] = kappcoeff(datams,datam2)
a = unique(datam2);
types = a(2:end);
n = length(types);
[row,col] = size(datam2);
total = row*col;
kappavector = zeros(1,n);
for i = 1:n
    id0 = find(datams == types(i));
    b1 = length(id0);
    b0 = length(find(datams ~= types(i)));
    id1 = find(datam2 == types(i));
    a1 = length(id1);
    a0 = length(find(datam2 ~= types(i)));
    idx = intersect(id0,id1);
    s = length(idx);
    po = s/total;
    pc = (a1*b1+a0*b0)/total/total;
    k = (po-pc)/(1-pc);
    kappavector(i) = k;
end