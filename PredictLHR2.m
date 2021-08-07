function [simparas,simurbannums] = PredictLHR2(datam,fdata,dplannedeve,Qujian2,planning,d,numbertrails,path11,wi)
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


% w2 = weightssampling2(1,0,6,numbertrails);
% MR = zeros(1,numbertrails);

%bestpara = [w0(1,:),0];
rows = xrow-d;
cols = ycol-d;
% maxurban = 0;
datam1 = datam{1};
datam3 = datam{2};
[s1,s2] = size(datam1);


%bestsimstates = datam1;
%besturbann=800;
%simresults = cell(1,numbertrails);
simkappa = zeros(1,numbertrails);
simmr = zeros(1,numbertrails);
paralength = length(wi)+1;
simparas = zeros(numbertrails,paralength);
simurbannums= zeros(1,numbertrails);
[tansferP, neighbor_m] =probmatrix2(datam1,datam3,d);
Gconfusion_m  = transrate3(Qujian2,dt,nt);
[probmaps1] = logitReg5(datam1,datam3,fdata11);
[probmaps2] = logitReg5(datam1,datam3,fdata12);
[probmaps3] = logitReg5(datam1,datam3,fdata13);
fprintf('START THE LOOP\n');
for simnum = 1:numbertrails
    probmaps11 = probmaps1;
    probmaps12 = probmaps2;
    probmaps13 = probmaps3;

    planning2 = planning;
    Qujian = Qujian2;
    cellsize = (2*d+1)^2;
    Niterations = simnum;
    wi1 = wi;
    types2 = types;

    sigma = Sigmas(simnum);
    state_trans = datam3;
    probabilitymap = zeros(xrow,ycol);
    %effect of transportation
    StepSize = 1;
    pi = zeros(1,nt);
    transferprobs1 = zeros(xrow*ycol,k+5);
    id1 = datam3 ==types2(end);
    transferprobs1(id1,end) = 1;
    while (StepSize<=dt)
        transferprobs1(:,1:k+4) = -9999;
        for i = 1+d:rows
            for j = 1+d:cols
                ylab = (j-1)*xrow+i;
                if datam3(i,j)>0&&transferprobs1(ylab,end) == 0
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
                    
                    index = find(types == datam3(i,j));
%                     logitsuit11 = probmaps11{index};
%                     logitindex11 = probindes11{index};
%                     logitsuit12 = probmaps12{index};
%                     logitindex12 = probindes12{index};
%                     logitsuit13 = probmaps13{index};
%                     logitindex13 = probindes13{index};
%                     id11 = logitindex11 == ylab;
%                     id12 = logitindex12 == ylab;
%                     id13 = logitindex13 == ylab;

                    InheritP = tansferP;
                    neighbor_trans1 = Naverageeffect3(neighbors,1,types,neighbor_m);
                    %rp=1;
                    rp = (1-(rand()^9.77));
                    for iter = 1:nt
                        logistmaps11 = probmaps11{iter};
                        logistmaps12 = probmaps12{iter};
                        logistmaps13 = probmaps13{iter};
                        
                        if iter <nt
                            pi(iter) = (wi1(1)*InheritP(index,iter)+wi1(2)*neighbor_trans1(iter)+wi1(6)*logistmaps11(ylab)+ wi1(7)*logistmaps12(ylab)+wi1(8)*logistmaps13(ylab))*rp;
                        else
                            pi(nt) =   (wi1(1)*InheritP(index,nt)+wi1(2)*neighbor_trans1(nt)+wi1(3)*logistmaps11(ylab)+ wi1(4)*logistmaps12(ylab)+wi1(5)*logistmaps13(ylab))*rp;
                        end
                        %pi(iter) = (0.5*InheritP(index,iter)+0.844*neighbor_trans1(iter));
                        
                    end
                    if dplannedeve(i,j) == 1
                        pi(end)=pi(end)*1.2;
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
    namei = strcat('simresult',num2str(2),'.txt');
    fileName=strcat('pre\',namei);
    writeGrid2Arc2(fileName,s2,s1,xllcorner,yllcorner,cellsizen,ini_state1)
    namei2 = strcat('probabilitymap',num2str(2),'.txt');
    fileName2=strcat('pre\',namei2);
    writeGrid2Arc2(fileName2,s2,s1,xllcorner,yllcorner,cellsizen,probabilitymap)
    %[MR1,kappacoef] = MatchingRate2(ini_state1,datam3,d);
    %simkappa(simnum) = kappacoef;
    %simmr(simnum) = MR1;
    simparas(simnum,:) = [wi1,sigma];

    targeturbanlands = length(find(ini_state1==58));
    simurbannums(simnum) = targeturbanlands;
    fprintf('FINISH THE %d iteration!!!\n', Niterations);

end
end