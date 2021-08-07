%%d starts from 0 with only one cell
function [Gconfusionm] = probmatrix4(mapdata1,mapdata2,Qujian,codenum,d)
[xrow,ycol] = size(mapdata1);
tt = unique(mapdata1);
ids = find(Qujian==codenum);
md1 = mapdata1(ids);
md2 = mapdata2(ids);
total = length(ids);
types = tt(2:end);
n = length(types);
nums = zeros(1,n);
%Calculate Genertic Transfer Probability
genertic_m = zeros(n,n);
genertic_m2= zeros(n,n);
Gconfusionm = zeros(n,n);
for i = 1:n
    nums(i) = length(find(md1 == types(i)));
    index  =  md1 == types(i);
    for j = 1:n
        index2 = find(md2(index) == types(j));
        a1 = length(index2);
        genertic_m(i,j) = a1;
        Gconfusionm(i,j) = a1;
    end
    if sum(genertic_m(i,:)) ~= 0
        genertic_m2(i,:) = genertic_m(i,:)/sum(genertic_m(i,:));
    else
        genertic_m2(i,:) = 0;
    end
    %genertic_m2(i,:) = floor(genertic_m2(i,:)*10)/10;
end

end