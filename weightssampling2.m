function wi = weightssampling2(max,min,cols,nsamples)
wi = zeros(nsamples,cols);
for i = 1:cols
    if i == 1
        wi(:,i) = lhsu2(min,max,nsamples);
    elseif i>1 && i <cols
        for j = 1:nsamples
            wi(j,i) = lhsu2(min,max-sum(wi(j,1:i-1)),1);
        end
    else
        wi(:,i) = max-sum(wi(:,1:i-1),2);
    end
end