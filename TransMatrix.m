%%d starts from 0 with only one cell
function [Gconfusionm] = TransMatrix(mapdata1,mapdata2,d)
s1 = size(mapdata1);
s2 = size(mapdata2);
if s1(1) == s2(1)&&s1(2) == s2(2)
    [xrow,ycol] = size(mapdata1);
    tt = unique(mapdata1);
    totalc =  xrow*ycol;
    total = xrow*ycol - length(find(mapdata1==tt(1)));
    types = tt(2:end);
    n = length(types);
    nums = zeros(1,n);
    %Calculate Genertic Transfer Probability
    genertic_m = zeros(n,n);
    genertic_m2= zeros(n,n);
    Gconfusionm = zeros(n+2,n);
    for i = 1:n
        nums(i) = length(find(mapdata1 == types(i)));
        index  =  mapdata1 == types(i);
        for j = 1:n
            index2 = find(mapdata2(index) == types(j));       
            a1 = length(index2);
            Gconfusionm(i,j) = a1;
        end
    end
    GMatrix = Gconfusionm(1:n,1:end);
    Gconfusionm(n+1,:) = sum(GMatrix,1);
    Gconfusionm(n+2,:) = sum(GMatrix,2)';
end