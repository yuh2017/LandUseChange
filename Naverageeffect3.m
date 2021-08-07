function newNP2 = Naverageeffect3(neighbors,beta,types,NEP)
n = length(neighbors);
NP = NEP.^beta;
tt0 = unique(neighbors);
tt = tt0(2:end);
types2 = tt;
nt = length(types);
newNP2=zeros(1,nt);
for tpi = 1:nt
    newNP = 0;
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
    newNP2(tpi) = newNP/(n-1);
end

end
