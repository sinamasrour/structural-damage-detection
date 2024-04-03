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

sz=size(xLB); %1
nVar=length(xLB);
NumGenes=nVar;

Pr=.05;Pv=0.25;b=5;
DeltF=@(t,y,T,b) (y.*(1-rand.^((1-t/T).^b)));

NumItrs=NFE_Max/PopSize/2;

% + + + main loop + + +
while NFE<NFE_Max
    
    for i=1:PopSize
        x=xMat(i,:);
        
        if rand<0.5
            r1=rand;
            xTeacher=Gbest;
            xMean=mean(xMat);
            Tf=round(1+rand);
            vNew=r1*(Gbest-Tf*xMean);
            xNew=x+vNew;
            xInd=i;
            GreedySelection;
            if NFE==NFE_Max, break,end
            
        else
            
            if rand<Pr % Receptor
                %id=randperm(NumGenes,1);
                id=randi(NumGenes);
                
                if round(rand)==0
                    dd=+DeltF(Iter,xUB(id)-x(id),NumItrs,b);
                else
                    dd=-DeltF(Iter,x(id)-xLB(id),NumItrs,b);
                end
                x(id)=x(id)+dd;
            end
            
            if rand<Pv %Vaccination
                %id=randperm(NumGenes,1);
                id=randi(NumGenes);
                
                x(id)=xUB(id);
            end
            
            xNew=x;
            
            xInd=i;
            GreedySelection;
            if NFE==NFE_Max, break,end
            
        end
    end
    
    % Learning-Phase
    for ii=1:PopSize
        
        tmp=randperm(PopSize);
        i=tmp(1);
        j=tmp(2);
        x=xMat(i,:);
        
        r2=rand;
        if Costs(j)<Costs(i)
            vNew=r2*(xMat(j,:)-xMat(i,:));
        else
            vNew=-r2*(xMat(j,:)-xMat(i,:));
        end
        
        xNew=x+vNew;
        xInd=i;
        GreedySelection;
        if NFE==NFE_Max, break,end
    end
    
    vMat=xMat-xMat_old;
    Iter=Iter+1;
    HistGbestCostIter(Iter)=GbestCost;
    if NFE==NFE_Max, break,end
end