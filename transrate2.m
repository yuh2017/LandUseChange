function [TransM ] = transrate2(datam1,datam2,Qujian2,d,dt,nt)
id = unique(Qujian2);
n = length(id);
TransM = cell(1,n-1);
for i = 2:n
    districti = id(i);
    [Gconfusionm] = probmatrix4(datam1,datam2,Qujian2,districti,d);

    fixM = fix(Gconfusionm(1:nt,1:nt)/dt);
    remM = rem(Gconfusionm(1:nt,1:nt),dt);
    randAM = randAllocation2(remM,dt);
    [s1,s2] = size(randAM);
    a1 = reshape(fixM,1,nt*nt);
    a2 = repmat(a1,s1,1);
    a3 =a2 +randAM;
    TransM{i-1} = a3;
end
end