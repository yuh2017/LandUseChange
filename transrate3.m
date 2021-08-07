function [TransM ] = transrate3(Qujian2,dt,nt)
id = unique(Qujian2);
n = length(id);
TransM = cell(1,n-1);
CM1 = [2988,0,0,0,0,61;0,4993,0,0,0,0;0,0,16423,0,0,101;0,0,0,3081,0,161;0,0,0,0,36324,6072;0,0,0,0,0,12404];
CM2 = [2817,0,0,0,0,65;0,7158,0,0,0,0;0,0,4635,0,0,28;0,0,0,3461,0,285;0,0,0,0,29264,10982;0,0,0,0,0,48379];
CM3 = [115,0,0,0,0,61;0,1299,0,0,0,0;0,0,5,0,0,0;0,0,0,101,0,12;0,0,0,0,1615,944;0,0,0,0,0,11230];
CM4 = [167,0,0,0,0,53;0,2426,0,0,0,0;0,0,57325,0,0,229;0,0,0,3837,0,138;0,0,0,0,20067,3834;0,0,0,0,0,6549];
CM5 = [2096,0,0,0,0,86;0,7402,0,0,0,0;0,0,870,0,0,6;0,0,0,2265,0,101;0,0,0,0,21363,8577;0,0,0,0,0,37799];
tcms = {CM1,CM2,CM3,CM4,CM5};
for i = 2:n
    Gconfusionm = tcms{i-1};

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