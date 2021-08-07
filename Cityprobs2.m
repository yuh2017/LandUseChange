function CitydataP = Cityprobs2(CityDisdata,beta2,datam1,Qujian2,types)
ini_state1 = datam1;
maxdistance = max(CityDisdata(:));
tt = unique(ini_state1);
nt = length(types);
[rows,cols] = size(CityDisdata); 
dataP = zeros(1,rows*cols);
CitydataP = zeros(nt,rows*cols);
for t = 1:nt
    for i = 1:rows
    for j = 1:cols
        ylab = (j-1)*rows+i;
        if CityDisdata(i,j) > 0 && CityDisdata(i,j) <maxdistance
             dataP(ylab) = (1-1/(1+exp(-1*beta2(t)*CityDisdata(i,j)))); 
%             if t <3
%                 dataP(ylab) = (1/(1+exp(-1*betasSuit(t)*ElevData(i,j))));
%             else
%                 dataP(ylab) = (1-1/(1+exp(-1*betasSuit(t)*ElevData(i,j))));
%             end
%             
%             if nt == 1
%                 if Qujian2(i,j) == 3
%                     dataP(ylab) = 1;
%                 else
%                     dataP(ylab) =  (1-CityDisdata(i,j)/maxdistance)^beta2(t);
%                 end
%             elseif nt == 2
%                 if Qujian2(i,j) == 4
%                     dataP(ylab) = (1-1/(1+CityDisdata(i,j)/5000))^beta2(t);
%                 elseif Qujian2(i,j) == 0
%                     dataP(ylab) = (1-1/(1+CityDisdata(i,j)/2000))^beta2(t);
%                 else
%                     dataP(ylab) = (1-1/(1+CityDisdata(i,j)/10000))^beta2(t);
%                 end
%             elseif nt == 3
%                 if Qujian2(i,j) == 0
%                     dataP(ylab) = 1;
%                 else
%                     dataP(ylab) = (1-CityDisdata(i,j)/maxdistance)^beta2(t);
%                 end
%             elseif t == nt -1
%                 if Qujian2(i,j) == 2
%                     dataP(ylab) = 1;
%                 elseif Qujian2(i,j) == 1||Qujian2(i,j) == 4  
%                     dataP(ylab) =  (1-CityDisdata(i,j)/maxdistance)^beta2(t);
%                 else
%                     dataP(ylab) =  (1-CityDisdata(i,j)/maxdistance)^beta2(t);
%                 end
%             elseif t == nt-2
%                 if CityDisdata(i,j) < 5000
%                     dataP(ylab) = (1-1/(1+CityDisdata(i,j)/maxdistance))^beta2(t);
%                 else
%                     dataP(ylab) =  (1/(1+CityDisdata(i,j)/maxdistance))^beta2(t);
%                 end
%             else
%                 if CityDisdata(i,j) < 10000
%                     dataP(ylab) = (1-1/(1+CityDisdata(i,j)/maxdistance))^beta2(t);
%                 else
%                     dataP(ylab) =  (1/(1+CityDisdata(i,j)/maxdistance))^beta2(t);    
%                 end
%             end
        end
    end
    end
    CitydataP(t,:) = dataP;
end
end