% ING
%% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% a variant of
%  Teacher-Learner-Based Optimization

%
%% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function [Gbest,GbestCost,ConvCurve,HistGbestCostIter,Iter]=TLBO_alg(PrbInfo,InitPop,NFE_Max)
% Initiation
Initiate4opt;

NumItrs=floor(1+(NFE_Max-PopSize)/PopSize/2);

cc=[1,2,2];
Ccognitive=cc(2);
Csocial=cc(3);

Fitness=-Costs;

sz=xLB;
PbestMat=xMat;
PbestFit=Fitness;
vMat=0*xMat;

% + + + main loop + + +
while NFE<NFE_Max
    Fitness=-Costs;
    
    Cinertial=(1+(Iter-1)/(NumItrs-1)*(0-1))*mean(cc);
    
    for i=1:PopSize
        x=xMat(i,:);
        Pbest=PbestMat(i,:);
        if Fitness(i) >PbestFit(i)
            PbestMat(i,:)=x;
            PbestFit(i)=-Costs(i); %Fitness(i);
        end
        
        vNew=Ccognitive*rand(size(sz)).*(PbestMat(i,:)-x)+Csocial*rand(size(sz)).*(Gbest-x);
        
        xNew=xMat(i,:)+vNew;
        xInd=i;
        GreedySelection;
        if NFE==NFE_Max, break,end
        
        tmp=randperm(PopSize/2);
        vNew=Cinertial*rand(size(sz)).*vMat(i,:)+cc(1)*rand(size(sz)).*(Gbest-(1+rand)*mean(xMat(tmp,:)));
        
        xNew=xMat(i,:)+vNew;
        xInd=i;
        GreedySelection;
        if NFE==NFE_Max, break,end
        
    end
      
    vMat=xMat-xMat_old;
    Iter=Iter+1;
    HistGbestCostIter(Iter)=GbestCost;
    if NFE==NFE_Max, break,end
end