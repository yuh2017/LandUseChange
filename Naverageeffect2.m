function newNP = Naverageeffect2(neighbors,beta,tpi,types,NEP)
n = length(neighbors);
NP = NEP.^beta;
tt = unique(neighbors);
types2 = tt;
newNP=0;
for i = 1:length(tt)
    if any(tt == 0)
        newNP = newNP+0;
    else
        nn = length(find(neighbors == types2(i)));
        if find(types == types2(i)) 
            index = types == types2(i);
            newNP = NP(index,tpi)*nn+newNP;
        else
            continue;
        end
        
    end
end
newNP = newNP/(n-1);
end
