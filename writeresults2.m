function writeresults2(fileName,simparas,simkappa,simmr,simurbannums)
%���ڽ�matlab�е��������ݴ浽arcgis�е�ascii�ļ���
%filename:���ڴ�ŵ��ļ�����nz:�д�С��mz:�д�С��xllcorner:x���½ǣ�
%yllcorneer:y���½ǣ�cellsize�������С��
%ZҪд�����ֵ��
%����д���������ݾ��пռ����ꡣ
%ʹ��ʾ����
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