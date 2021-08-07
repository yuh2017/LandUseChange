[xllcorner,xmax,yllcorner,ymax,cellsize,nx,ny]=read_AGaschdr2(path11);
fileName='Results\simstates.txt';
writeGrid2Arc2(fileName,s2,s1,xllcorner,yllcorner,cellsize,bestsimstates)
% dlmwrite(,bestsimstates , 'delimiter', '\t','precision', 3);
% dlmwrite('C:\Users\Administrator\Desktop\CA Results\transdata1.txt',transdata2 , 'delimiter', '\t','precision', 3);
ini_state = datam2;
figure(6)
n1 = length(types);
urban1=zeros(1,n1);
urban2=zeros(1,n1);
urban3=zeros(1,n1);
for i = 1:n1
    urban1(i) = length(find(bestsimstates==types(i)));
end
for i = 1:n1
    urban2(i) = length(find(datam{1}==types(i)));
end
for i = 1:n1
    urban3(i) = length(find(datam{2}==types(i)));
end
A = [urban1;urban2;urban3];
h = bar(A');
name = {'WetLand';'River';'Forest';'Grass';'Agriculture';'Urban'};
set(gca,'xticklabel',name)
grid on
l = cell(1,3);
l{1} = 'Simulated Land';
l{2} = '1995 Land use';
l{3} = '2005 Land use';
legend(h,l)