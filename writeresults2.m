function writeresults2(fileName,simparas,simkappa,simmr,simurbannums)
%用于将matlab中的运算数据存到arcgis中的ascii文件中
%filename:用于存放的文件名，nz:行大小，mz:列大小，xllcorner:x左下角，
%yllcorneer:y左下角，cellsize：网格大小，
%Z要写入的数值。
%这样写出来的数据具有空间坐标。
%使用示例：
%writeGrid2Arc('D:\workDir\new6.txt',2209,2681,400641.6875,2800599,30,dsm);
%
fid=fopen(fileName,'wt');
n = length(simparas(:,1));
for i=1:n
    fprintf(fid,'%f\n',simparas(i,:));    
    fprintf(fid,'%f\t',i);
    fprintf(fid,'%f\t',simkappa(i));
    fprintf(fid,'%f\t',simmr(i));
    fprintf(fid,'%f\n',simurbannums(i));
    %update waitbar
%    waitbar(i/mz,h,['Writing file: ',[fname,ext],...
  %  sprintf('  %d%% complete...',round(i/mz*100))])
end
fclose(fid);