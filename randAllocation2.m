function  randAM = randAllocation2(remM,dt)
[s1,s2] = size(remM);
randAM = zeros(dt,s1*s2);
for i = 1:s1
    for j = 1:s2
        ylab = (j-1)*s1+i;
%         fprintf('%d\n',remM(i,j));
%         fprintf('%d\n',remM(ylab));
        if remM(i,j)>0
            A = randint(1,remM(i,j),[1,dt]);
            for k = 1:dt
                if any(A==k)
                    randAM(k,ylab) = randAM(k,ylab)+1;
                end
            end
        end
    end
end
end