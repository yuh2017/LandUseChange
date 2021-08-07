function [xmin,xmax,ymin,ymax,dx,nx,ny]=read_AGaschdr2(hdr_file)
[names,values] = textread(hdr_file,'%s%f',5);
nx=values(1);
ny=values(2);
xmin=values(3);
ymin=values(4);
dx=values(5);
xmax=xmin+(nx-1)*dx;
ymax=ymin+(ny-1)*dx;
end