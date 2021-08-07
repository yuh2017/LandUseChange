function [TransM ] = transrate(datam1,datam2,d,dt,nt)
%[Gconfusionm] = probmatrix3(datam1,datam2,d);
Gconfusionm = [8097,0,0,0,97,329;0,23301,0,0,0,0;0,0,79443,0,0,364;0,0,0,12849,0,597;0,0,0,0,96762,41413;0,0,123,124,200,116000];
fixM = fix(Gconfusionm(1:nt,1:nt)/dt);
remM = rem(Gconfusionm(1:nt,1:nt),dt);
randAM = randAllocation2(remM,dt);
[s1,s2] = size(randAM);
a1 = reshape(fixM,1,nt*nt);
a2 = repmat(a1,s1,1);
a3 =a2 +randAM;
TransM = a3;
end