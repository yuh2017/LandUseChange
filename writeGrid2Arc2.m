function writeGrid2Arc2(fileName,nz,mz,xllcorner,yllcorner,cellsize,Z)
%���ڽ�matlab�е��������ݴ浽arcgis�е�ascii�ļ���
%filename:���ڴ�ŵ��ļ�����nz:�д�С��mz:�д�С��xllcorner:x���½ǣ�
%yllcorneer:y���½ǣ�cellsize�������С��
%ZҪд�����ֵ��
%����д���������ݾ��пռ����ꡣ
%ʹ��ʾ����
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