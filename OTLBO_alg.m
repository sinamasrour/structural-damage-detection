% ING
%% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +  
% a variant of 
% Observer-Teacher-Learner-Based Optimization 
%  by Dr.M.Shahrouzi
% Ref.: 10.12989/sem.2017.62.5.537
%
%% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

function [Gbest,GbestCost,ConvCurve,HistGbestCostIter,Iter]=OTLBO_alg(PrbInfo,InitPop,NFE_Max)
% Initiation
Initiate4opt;

sz=size(xLB); %1
nVar=length(xLB);
Ps=0.5;
% + + + main loop + + +
while NFE<NFE_Max   
   
   for i=1:PopSize
      if rand<Ps
         % Teacher-Phase
         xNew=xMat(i,:)+rand(sz).*(Gbest-round(1+rand)*mean(xMat));
         xInd=i;
         GreedySelection;
         if NFE==NFE_Max, break,end 
      else
         % Observer-Phase
         for k=1:nVar
            xNew(k)=xMat(randi(PopSize),k);
         end
         
         xInd=i;
         GreedySelection;
         if NFE==NFE_Max, break,end 
      end
      % Learner-Phase
      tmp=randperm(PopSize-1);
      j=i+tmp(1);
      if j>PopSize,
         j=i+tmp(1)-PopSize;
      end
      if Costs(j)<Costs(i)
         vNew=rand*(xMat(j,:)-xMat(i,:));
      else
         vNew=-rand*(xMat(j,:)-xMat(i,:));
      end
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

