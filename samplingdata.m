function [index] = samplingdata(fdata,datam2,datam1,typesi)
flength = length(fdata);
totaln = unique(datam1);
types = totaln(2:end);
tn = length(types);
[s0,s1] = size(datam1);
x0index=[];
for i=1:30:s0
    for j = 1:30:s1
        ylab = (j-1)*s0+i;
        if datam1(i,j) == types(typesi)
            x0index = [x0index,ylab];
        end
    end
end
x0train = datam1(x0index);
indexnega  = find(x0train>0);
index1 = find(datam1>0);
if ~isempty(index1)
    ssampleid = x0index;
    
    leftid = index1;
    leftn = length(leftid);
    nsample = length(ssampleid);
    md3kn = datam2(leftid);
    nid = length(md3kn);
    rsn0 = fix(nid*0.05);
    randselect = randperm(leftn);
    randsampleid = randselect(1:rsn0);
    randid =  index1(randsampleid);
    tilength = nsample+rsn0;
    xtrain1 = zeros(tilength,flength);
    sid = [ssampleid,randid'];
    
   
    for fi = 1:flength
        fxi = fdata{fi};
        aaa = reshape(fxi(sid),1,tilength);
        xtrain1(:,fi) = aaa;
    end
    md3k1 = datam1(sid);
    md3k2 = datam2(sid);
    md3k = md3k1;
    j = tn;
    index2 =  find(md3k1==types(j));
    index4 =  find(md3k2==types(j));
    index5 =  find(md3k2~=types(j));
    index3 = setdiff(index4,index2);
    md3k(index5) = 0;
    md3k(index4) = 1;
    
    X = xtrain1;
    Y = reshape(md3k,tilength,1);

    n2 = length(find(Y==1));
    rn =randperm(numel(Y));
    idy = rn(1:n2);
    [a1,b1] = size(idy);
    idy2 = find(Y==1);
    idt = [reshape(idy,b1,a1);idy2];
    X2 = X(idt,:);
    Y2 = Y(idt);
end
end