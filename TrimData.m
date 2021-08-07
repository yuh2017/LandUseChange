function Trimeddata = TrimData(data0)
[s1,s2] = size(data0);
Trimeddata =data0;
del = 0;
for i = 1:s1
    if unique(data0(i,:)) == -9999
        Trimeddata(i-del,:) = [];
        del=del+1;
    elseif unique(data0(i,:)) == 0
        Trimeddata(i-del,:) = [];
        del=del+1;
    end
end
del2 = 0;
for j = 1:s2
    if unique(data0(:,j)) == -9999
        Trimeddata(:,j-del2) = [];
        del2 = del2+1;
    elseif unique(data0(:,j)) == 0
        Trimeddata(:,j-del2) = [];
        del2 = del2+1;
    end
end

end



