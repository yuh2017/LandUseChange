function [MR,kappa_coeff,Kappa] = MatchingRate2(ndatam1,datam2,d)
%%MR
[rows,cols] = size(ndatam1);
total = 0;
counts = 0;
for i = 1:rows
    for j = 1:cols
        if ndatam1(i,j) ~= 0
            if ndatam1(i,j) == datam2(i,j)
                counts = counts+1;
                total = total+1;
            else
                total = total+1;
            end
        end
        
    end
end
MR = counts/total;
%%Kappa
tt = unique(datam2);
types = tt(2:end);
k = length(types)+1;
Kappa = zeros(k,k);
[xrow,ycol] = size(datam2);
rows = xrow-d;
cols = ycol-d;
for i = 1+d:rows
    for j = 1+d:cols
        if ndatam1(i,j)~=0
            n1 = find(types == ndatam1(i,j));
            n2 = find(types == datam2(i,j));
            if(n1 == n2)
                Kappa(n1,n1) = Kappa(n1,n1)+1;
            else
                Kappa(n2,n1) = Kappa(n2,n1)+1;
            end
        end
    end
end
Kappa(k,:) = sum(Kappa);
Kappa(:,k) = sum(Kappa,2);
kappak_1 = Kappa(1:k-1,1:k-1);
Kappa(k,k) = sum(kappak_1(:));
%%kappa_coeff
kii = 0;
xyi=0;
tt = Kappa(k,k);
for i = 1:k-1
    kii=kii+Kappa(i,i);
    xyi =xyi+ Kappa(k,i)*Kappa(i,k);
end
kappa_coeff = (tt*kii-xyi)/(tt^2-xyi);
end