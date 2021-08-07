function writeGrid2Arc2(fileName,nz,mz,xllcorner,yllcorner,cellsize,Z)
%用于将matlab中的运算数据存到arcgis中的ascii文件中
%filename:用于存放的文件名，nz:行大小，mz:列大小，xllcorner:x左下角，
%yllcorneer:y左下角，cellsize：网格大小，
%Z要写入的数值。
%这样写出来的数据具有空间坐标。
%使用示例：
%writeGrid2Arc('D:\workDir\new6.txt',2209,2681,400641.6875,2800599,30,dsm);
%
fid=fopen(fileName,'wt');
 
dc=3; 
%default number of decimals to output
if isnumeric(dc)
    dc=['%.',sprintf('%d',dc),'f'];
elseif isnumeric(dc) && dc==0
    dc=['%.',sprintf('%d',dc),'d'];
end
 
%write header
fprintf(fid,'%s\t','ncols');
fprintf(fid,' %d\n',nz);
fprintf(fid,'%s\t','nrows');
fprintf(fid,' %d\n',mz);
fprintf(fid,'%s\t','xllcorner');
fprintf(fid,[dc,'\n'],xllcorner);
fprintf(fid,'%s\t','yllcorner');
fprintf(fid,[dc,'\n'],yllcorner);
fprintf(fid,'%s\t','cellsize');
fprintf(fid,[dc,'\n'],cellsize);
fprintf(fid,'%s\t','NODATA_value');
fprintf(fid,[dc,'\n'],0.000);

for i=1:mz
    for j=1:nz
        if j==nz
            fprintf(fid,[dc,'\n'],Z(i,j));
        else
            fprintf(fid,[dc,'\t'],Z(i,j));
        end
    end
    %update waitbar
%    waitbar(i/mz,h,['Writing file: ',[fname,ext],...
  %  sprintf('  %d%% complete...',round(i/mz*100))])
end
fclose(fid);