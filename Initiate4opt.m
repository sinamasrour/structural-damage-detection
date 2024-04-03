xLB=PrbInfo.xLB;
xUB=PrbInfo.xUB;

xMat=InitPop.xMat;
Costs=InitPop.Costs;
Infeas=InitPop.Infeas;
PopSize=size(xMat,1);

Iter=1;
NFE=PopSize;

GbestCost=inf;
GbestInfeas=inf;
for i=1:PopSize    
    if Costs(i)<=GbestCost & (Infeas(i)<=GbestInfeas)
        Gbest=xMat(i,:);
        GbestCost=Costs(i);
        GbestInfeas=Infeas(i);
    end
end

HistGbestCostIter(Iter)=GbestCost;
CostS=(Infeas==0).*Costs+(Infeas>0)*GbestCost;
for NFE=1:PopSize
    ConvCurve(NFE)=min(CostS(1:NFE));
end

xMat_old=xMat;
vMat=xMat-xMat_old;