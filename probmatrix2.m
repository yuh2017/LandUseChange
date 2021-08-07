%%d starts from 0 with only one cell
function [genertic_m2,neighbor_m] = probmatrix2(mapdata1,mapdata2,d)
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
%             length(mapdata2(index))
%             length(index)
            index2 = find(mapdata2(index) == types(j));       
            a1 = length(index2);
%             l = a1-a2;
%             s = sum(~~l(:));
%             ans = numel(l) - s;
            genertic_m(i,j) = a1;
            Gconfusionm(i,j) = a1;
        end
        genertic_m2(i,:) = genertic_m(i,:)/sum(genertic_m(i,:));
        
        %genertic_m2(i,:) = floor(genertic_m2(i,:)*10)/10;
    end
    
    GMatrix = Gconfusionm(1:n,1:end);
    Gconfusionm(n+1,:) = sum(GMatrix,1);
    Gconfusionm(n+2,:) = sum(GMatrix,2)';
    %%Calculate Average Fengdu 
    F_ini = zeros(n,totalc);
    F_pos = zeros(n,totalc);
    neighbor_m = zeros(n,n);
    rows = xrow-d;
    cols = ycol-d;
    cellsize= (2*d+1)^2;
    for i = 1+d:rows
        for j = 1+d:cols
            ylab = (j-1)*xrow+i;
            nm = zeros(1,n);
            %%±ß³¤ 2d(d+1)
            neighbors= zeros(1,cellsize);
            itern = 1;
            for ii = i-d:i+d
                for jj = j-d:j+d
                    neighbors(itern) = mapdata1(ii,jj);
                    itern =itern+1;
                end
            end
            for k2 = 1:n
                nn = length(find(neighbors ==types(k2)));
                 
                totalneighbor = length(neighbors);%recursion(d);
                prob = nn/totalneighbor/nums(k2)*total;
                nm(k2) = prob;
                F_ini(k2,ylab) = prob;
            end
       end 
    end
    
    for kkk = 1:n
        %%use mapdata1 to calculate avg fendu
        data2index = mapdata2==types(kkk);
        F = F_ini(:,data2index);
%         FF = zeros(n,1);
        f = mean(F,2);
%         for i = 1:n
%            s = F(i,:);
%            m = mean(s);
%            FF(i) = m;
%         end
        %c = length(F_ini(1,data2index));
        %deno = max(f/c);
        neighbor_m(:,kkk) = f;
    end
    
    for kkk = 1:n
        neighbor_m(kkk,:)=neighbor_m(kkk,:)/sum(neighbor_m(kkk,:));
        %neighbor_m(:,kkk) = floor(neighbor_m(:,kkk)*10)/10;
    end
else
    neighbor_m = [1,0.4,0.7,0.9,0,0.2;
            0.1,1,0,0,0.2,0;
            0.4,0.4,1,0.2,0.6,0.2;
            0.2,0.4,0,1,0.8,0.2;
            0.1,0.2,0,0,1,0;
            0.2,0.1,0,0,0.2,1];
    genertic_m = [1,0,0,0,0,0;
            0,1,0,0,0.2,0;
            0.3,0.4,1,0.2,0.6,0.2;
            0.2,0.4,0,1,0.8,0.2;
            0.5,0.2,0,0,1,0;
            0.3,0.1,0,0,0.2,1];
end
end