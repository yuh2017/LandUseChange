% [a,b] = sort(simmr,'descend');
% bbb = zeros(1,100);
for i = 1:50
    ph3 = strcat('Results3\simresult',num2str(i),'.txt');
    datamm = readdataWOReClass2(ph3);
    figure(10)
    image(datamm);
   [MR1,kappacoef] = MatchingRate2(datamm,datam3,d);
   %bbb(i) = kappacoef;
 %  pause(1.5);
end