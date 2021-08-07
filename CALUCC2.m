%%%%%%%%%%%%%%%Urban Land Use Change Cellular Automata(CA) Model%%%%%%%%%%
%%Author: Yu Han @2015.01.14
%ii=round(5*rand(20,20));
%ii2= round(5*rand(20,20));C:\Users\Administrator\Desktop\resampled\
path11 = 'TXT100\luc1995.txt';
path12 =  'TXT100\luc2005.txt';
path13 = 'TXT100\luc2015ras.txt';
% buffered road pathcitynear.txt
% pathhighwayd = 'TXT100\txt features\txt05\highwayd.txt';
% pathmainroad = 'TXT100\txt features\txt05\mainroadd.txt';
% pathbypass = 'TXT100\txt features\txt05\bypassd05.txt';
% pathcigan = 'TXT100\txt features\txt05\cigan05.txt';
pathhighwayd = 'TXT100\txt features\txt14\highway2014.txt';
pathmainroad = 'TXT100\txt features\txt14\mainroad2014.txt';
pathbypass = 'TXT100\txt features\txt14\zhidao14.txt';
pathcigan = 'TXT100\txt features\txt14\cigan14.txt';
pathbridge = 'TXT100\txt features\bridgedist.txt';
pathfastroad = 'TXT100\txt features\fastrdist.txt';

elevation = 'TXT100\txt features\elev2.txt';
pathslope = 'TXT100\txt features\slope2.txt';
pathparkd = 'TXT100\txt features\parkd05.txt';
% 
% pathCityDis = 'TXT100\txt features\txt05\cityd05.txt';
% pathsubCityDis ='TXT100\txt features\txt05\indusd05.txt';
pathCityDis ='TXT100\txt features\txt14\cityd.txt';
pathsubCityDis ='TXT100\txt features\txt14\suburband14.txt';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pathriverdist = 'TXT100\txt features\driver.txt';

boundary = 'TXT100\txt features\districtid.txt';
Scenario1plan = 'TXT100\Scenarios\Scenarios\zoningplan.txt';
Scenariosplan='TXT100\Scenarios\Scenarios\diffusiveplan.txt';
Scenario0plan = 'TXT100\Scenarios\Scenarios\growthlimitplan.txt';  %developz ecological


planned = 'TXT100\Scenarios\Scenarios\ecological.txt';  %developz ecological
plannedeve = 'TXT100\Scenarios\developz.txt';  %developz ecological
planned14 = 'TXT100\txt features\txt14\planned14.txt';
planned05 = 'TXT100\txt features\planned05.txt';
conseve14 = 'TXT100\Scenarios\ecological.txt';
% %%%%%%%%%%%%% Read Data from path %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datam1 = readdataWOReClass2(path11);
datam2 = readdataWOReClass2(path12);
datam3 = readdataWOReClass2(path13);

citydata= readfeatures(pathCityDis);
subcitydata= readfeatures(pathsubCityDis);
cigandata= readfeatures(pathcigan);
parkd = readfeatures(pathparkd);

riverData = readfeatures(pathriverdist);

roadhData = readfeatures(pathhighwayd);
roadmData = readfeatures(pathmainroad);
roadbData = readfeatures(pathbypass);
roadbridge = readfeatures(pathbridge);
roadfast = readfeatures(pathfastroad);

elevData = readfeatures(elevation);
slopeData = readfeatures(pathslope);
dboundary = readfeatures(boundary);
dplanned = readfeatures(planned);
dplannedeve = readfeatures(plannedeve);
plan14 = readfeatures(planned14);
plan05 = readfeatures(planned05);

sceplan1=readfeatures(Scenario0plan);
sceplan2 =readfeatures(Scenario1plan);
sceplan3=readfeatures(Scenariosplan);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% datam3 = TrimData(datamm2);
% datam4 = TrimData(datamm3);
% datam5 = TrimData(datamm4);
%%%%%%%%%%%%%%%%%%Adjust data matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[s1,s2] = size(datam1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tt1 = unique(datam1);
ntypes = length(tt1);
%simulated number of trails
numbertrails = 200;
d = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = ntypes-1;
types =tt1(2:end);
datam = {datam1,datam2};
datamv = {datam2,datam3};
fdata ={roadhData,roadmData,roadbData,cigandata,riverData,roadbridge,roadfast,parkd,citydata,subcitydata,elevData,slopeData};
fprintf('finished reading\n');
%[MRR,kappa2coef] = MatchingRate2(datam1,datam2,d);
[simkappa,simmr,simparas,simurbannums]  = LHRandomSampling2(datamv,fdata,dboundary,plan14,d,numbertrails,path11);
% filesimmr = 'Results3\simMR.txt';
% writeresults2(filesimmr,simparas,simkappa,simmr,simurbannums)
%%%%%%%%%%%Scenario 1 diffusive SubURBAN DISTANCE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pathsubCityDis ='TXT100\Scenarios\Scenarios\sec1\6.25\22\suburband22.txt';
pathbypass = 'TXT100\Scenarios\Scenarios\sceroads\11\zhidao11.txt';
pathcigan = 'TXT100\Scenarios\Scenarios\sceroads\11\cigan11.txt';
pathhighwayd = 'TXT100\Scenarios\Scenarios\sec1\6.25\22\highwayd22.txt';
pathmainroad = 'TXT100\Scenarios\Scenarios\sec1\6.25\22\mainroadd22.txt';
pathCityDis ='TXT100\Scenarios\Scenarios\sec1\6.25\22\cityd22.txt';
%%%%5%%%%%%%%%%%%%%%Scenario 2 zoning SubURBAN DISTANCE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pathsubCityDis ='TXT100\Scenarios\Scenarios\sec2\6.25\11\suburband11.txt';
%%%
pathbypass = 'TXT100\Scenarios\Scenarios\sceroads\22\zhidao22.txt';
pathcigan = 'TXT100\Scenarios\Scenarios\sceroads\22\cigan22.txt';
% %%%%5%%%%%%%%%%%%%%%Scenario 0 growth with limits %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pathbypass = 'TXT100\Scenarios\Scenarios\sceroads\00\zhidaod00.txt';
% pathcigan = 'TXT100\Scenarios\Scenarios\sceroads\00\cigand00.txt';
pathsce1='TXT100\202544.txt';
pathsce2='TXT100\202522.txt';
pathsce3='TXT100\202533.txt';

citydata= readfeatures(pathCityDis);
subcitydata= readfeatures(pathsubCityDis);
cigandata= readfeatures(pathcigan);


roadhData = readfeatures(pathhighwayd);
roadmData = readfeatures(pathmainroad);
roadbData = readfeatures(pathbypass);

datamp = readdataWOReClass2(pathsce2);
fdata ={roadhData,roadmData,roadbData,cigandata,riverData,roadbridge,roadfast,parkd,citydata,subcitydata,elevData,slopeData};
fprintf('finished reading\n');
%id0 = find(simmr==max(simmr));
%weights1 = simparas(id0,:);
weights1= [0.276447902413098,0.127949597064764,0.672821637793248,0.87484168500202,0.284734899154477,0.31299469504716,0.223821378256739,0.56533632607735,1];
[preparas,preurbannums] = PredictLHR2(datamv,fdata,dplannedeve,dboundary,sceplan1,d,1,path11,weights1);




% dlmwrite('C:\Users\Administrator\Desktop\CA Results\kappa.txt',kappa1 , 'delimiter', '\t','precision', 3);
% bestsimstates = simresults{2};
% figure(2)
% image(datam2);
% xlabel('2005 land use spatial distribution');
% figure(4)
% image(datam1);
% xlabel('1995 land use spatial distribution');
% 
% 
% [xllcorner,xmax,yllcorner,ymax,cellsize,nx,ny]=read_AGaschdr2(path11);
% fileName='Results\simstates15.txt';
% writeGrid2Arc2(fileName,s2,s1,xllcorner,yllcorner,cellsize,bestsimstates)
% % dlmwrite(,bestsimstates , 'delimiter', '\t','precision', 3);
% % dlmwrite('C:\Users\Administrator\Desktop\CA Results\transdata1.txt',transdata2 , 'delimiter', '\t','precision', 3);
% ini_state = datam2;
% figure(6)
% n1 = length(types);
% urban1=zeros(1,n1);
% urban2=zeros(1,n1);
% urban3=zeros(1,n1);
% for i = 1:n1
%     urban1(i) = length(find(bestsimstates==types(i)));
% end
% for i = 1:n1
%     urban2(i) = length(find(datam{1}==types(i)));
% end
% for i = 1:n1
%     urban3(i) = length(find(datam{2}==types(i)));
% end
% A = [urban1;urban2;urban3];
% h = bar(A');
% name = {'WetLand';'River';'Forest';'Grass';'Agriculture';'Urban'};
% set(gca,'xticklabel',name)
% grid on
% l = cell(1,3);
% l{1} = 'Simulated Land';
% l{2} = '1995 Land use';
% l{3} = '2005 Land use';
% legend(h,l)