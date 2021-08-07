function [simkappa,simmr,simparas,simurbannums] = LHRandomSampling2(datam,fdata,Qujian2,planning,d,numbertrails,path11)

fdata11 = fdata(1:6);
fdata12 = fdata(9:10);
fdata13 = fdata(11:12);


ini_state1 = datam{1};
tt = unique(ini_state1);
types = tt(2:end); %land use types except the background value
nt = length(types);
k = nt;
[xrow,ycol] = size(ini_state1);
t2 = 2010;
t1 = 2000;
deltat = 1;
dt = abs((t2-t1)/deltat);
%%Ramdom Sampling Parameters Part 
Sigmas = lhsu2(ones(1,1),ones(1,6),numbertrails);
%gamas = lhsu2([0,0,0,0,0,0],[10,10,10,10,10,10],numbertrails);
%betasGen = lhsu2(ones(1,6),ones(1,6),numbertrails);
%betasNeig = lhsu2([0,0,0,0,0,0],[10,10,10,10,10,10],numbertrails);

w0 = lhsu2([0.2,0.1,0.5,0.3,0,0,0,0],[1,0.8,1,0.9,0.5,0.6,0.6,0.6],numbertrails);
% w1 = weightssampling2(1,0,6,numbertrails);
% w2 = weightssampling2(1,0,6,numbertrails);
% MR = zeros(1,numbertrails);

%bestpara = [w0(1,:),0];
rows = xrow-d;
cols = ycol-d;
% maxurban = 0;
datam1 = datam{1};
datam3= datam{2};
[s1,s2] = size(datam1);


%bestsimstates = datam1;
%besturbann=800;
%simresults = cell(1,numbertrails);
simkappa = zeros(1,numbertrails);
simmr = zeros(1,numbertrails);
paralength = length(w0(1,:))+1;
simparas = zeros(numbertrails,paralength);
simurbannums= zeros(1,numbertrails);
[tansferP, neighbor_m] =probmatrix2(datam1,datam3,d);
Gconfusion_m  = transrate2(datam1,datam3,Qujian2,d,dt,nt);
[probmaps1] = logitReg5(datam1,datam3,fdata11);
[probmaps2] = logitReg5(datam1,datam3,fdata12);
[probmaps3] = logitReg5(datam1,datam3,fdata13);
fprintf('START THE LOOP\n');
parfor simnum = 1:numbertrails
    probmaps11 = probmaps1;
    probmaps12 = probmaps2;
    probmaps13 = probmaps3;
%     probid1=probindes1;
%     probid2=probindes2;
%     probid3=probindes3;
    
    planning2 = planning;
    Qujian = Qujian2;
    cellsize = (2*d+1)^2;
    Niterations = simnum;
    wi1 = w0(simnum,:);
    types2 = types;
    %wi1 = [0.3,0.14,0.08,0.1,0.03,0.07,0.1,0.18];
    %wi1 = [0.5,0.84,0.92,0.52,0.77];
%     wi2 = w1(simnum,:);
%     wi3 = w2(simnum,:);
    sigma = Sigmas(simnum);
    state_trans = datam1;
    probabilitymap = zeros(xrow,ycol);
    %effect of transportation
    StepSize = 1;
    pi = zeros(1,nt);
    transferprobs1 = zeros(xrow*ycol,k+5);
    id1 = state_trans ==types2(end);
    transferprobs1(id1,end) = 1;
    while (StepSize<=dt)
        transferprobs1(:,1:k+4) = -9999;
        for i = 1+d:rows
            for j = 1+d:cols
                ylab = (j-1)*xrow+i;
                if datam1(i,j)>0&&transferprobs1(ylab,end) == 0
                    neighbors = zeros(1,cellsize);
                    neighbordist = zeros(1,cellsize);
                    itern = 1;
                    for ii = i-d:i+d
                        for jj = j-d:j+d
                            celldistance = sqrt((ii-i)^2+(jj-j)^2);
                            if celldistance ~=0
                                neighbors(itern) = state_trans(ii,jj);
                                neighbordist(itern) = sqrt((ii-i)^2+(jj-j)^2);
                                itern =itern+1;
                            end
                        end
                    end
                    
                    index = find(types == datam1(i,j));
                    
                    InheritP = tansferP;
                    neighbor_trans1 = Naverageeffect3(neighbors,1,types,neighbor_m);
                    %rp=1;
                    rp = (1-(rand()^9.77));
                    for iter = 1:nt
                        logitsuit11 = probmaps11{iter};
                        %id1 = (probid1{iter}==ylab);
                        logitsuit12 = probmaps12{iter};
                        %id2 = (probid2{iter}==ylab);
                        logitsuit13 = probmaps13{iter};
                        %id3 = (probid3{iter}==ylab);
                        if iter <nt
                            pi(iter) = (wi1(1)*InheritP(index,iter)+wi1(2)*neighbor_trans1(iter)+0*logitsuit11(ylab)+ 0*logitsuit12(ylab)+0*logitsuit13(ylab))*rp;
                        else
                            pi(nt) =   (wi1(1)*InheritP(index,nt)+wi1(2)*neighbor_trans1(nt)+wi1(3)*logitsuit11(ylab)+ wi1(4)*logitsuit12(ylab)+wi1(5)*logitsuit13(ylab))*rp;
                        end
                            %pi(iter) = (0.5*InheritP(index,iter)+0.844*neighbor_trans1(iter));
                    end
                    
                    
                    if planning2(i,j) == 2
                        pi(:) = 0;
                        pi(2) = 0.94;
                    elseif planning2(i,j) == 3
                        pi(:) = 0;
                        pi(4) = 0.94;
                    elseif planning2(i,j) == 5
                        pi(:) = 0;
                        pi(5) = 0.94;
                    elseif planning2(i,j) == 6
                        pi(6) = 0.94;
                    end
                    if state_trans(i,j) == types(2)
                        pi(:) = 0;
                        pi(2)=10;
                    end
                    probs = pi;
                    transferprobs1(ylab,1:k) = probs;
                    transferprobs1(ylab,k+1) = max(probs);
                    transferprobs1(ylab,k+2) = ylab;
                    transferprobs1(ylab,k+3) = Qujian(i,j);
                    transferprobs1(ylab,k+4) = state_trans(i,j);
                    probabilitymap(i,j) = pi(end);
                end
            end
        end
        dcells = transferprobs1;
        loop = StepSize;
        fprintf('PREPARE %d year allocation\n',StepSize);
        [state_trans] = cellTransformation(state_trans,dcells,Gconfusion_m,types,loop,Qujian);
        StepSize = StepSize +1;
    end
    ini_state1 = state_trans;
    %simresults{simnum} = state_trans;
    [xllcorner,~,yllcorner,~,cellsizen,~,~]=read_AGaschdr2(path11);
    namei = strcat('simresult',num2str(simnum),'.txt');
    fileName=strcat('Results3\',namei);
    writeGrid2Arc2(fileName,s2,s1,xllcorner,yllcorner,cellsizen,ini_state1)
    namei2 = strcat('probabilitymap',num2str(simnum),'.txt');
    fileName2=strcat('Results3\',namei2);
    writeGrid2Arc2(fileName2,s2,s1,xllcorner,yllcorner,cellsizen,probabilitymap)
    [MR1,kappacoef] = MatchingRate2(ini_state1,datam3,d);
    simkappa(simnum) = kappacoef;
    simmr(simnum) = MR1;
    simparas(simnum,:) = [wi1,sigma];

    targeturbanlands = length(find(ini_state1==58));
    simurbannums(simnum) = targeturbanlands;
%     if MR1 >bestMR&&urbann1>68500
%         %&&urbann1<targeturbanlands+20&&urbann1>=targeturbanlands-25
%         %&&indus1<targetInduslands+20&&indus1>targetInduslands-20
%         figure(13)
%         image(bestsimstates)
%         xlabel('simulated land use spatial distribution');
%        
%         besturbann = urbann1;
%         bestpara = [wi1,sigma];
%         simparas(simnum,:) = bestpara;
%         %simparas(simnum,5:6) = wi2;
%         bestMR = MR1;
%         maxurban=urbann1;
%         bestkappa = kappacoef;
%         bg = neighborbetas;
%         bn = betasGen(simnum,:);
%         bestsimstates = state_trans;
%         figure(16)
%         image(bestsimstates)
%         xlabel('simulated land use spatial distribution');
%         pause(1)
%     end
    
    fprintf('FINISH THE %d iteration!!!\n', Niterations);
%     fprintf('the accuracy %f\n', MR1);
%     fprintf('the nums urban land %f\n', urbann1);
end
% figure(3)
% hist(MR)
% % h = findobj(gca,'Type','patch');
% % set(h,'FaceColor','r','EdgeColor','w')
% xlabel('Histogram of MR');
% figure(5)
% scatter(MR,numurbanlands,'filled','k');
% hold on
% if ~isempty(maxurban)
%     scatter(bestMR,maxurban,'filled', 'g');
%     hold on
%     scatter(MRR,urbann0,'filled', 'r');
% end
% xlabel('MatchingRate(MR)');
% ylabel('Number of Simulated urban land cells');
end