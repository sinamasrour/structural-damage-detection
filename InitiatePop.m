xLB=PrbInfo.xLB;
xUB=PrbInfo.xUB;

NFE=0;
for i=1:PopSize
    xMat(i,:)=xLB+rand(size(xLB)).*(xUB-xLB);    
    [Costs(i),Infeas(i)]=feval(PrbInfo.Fcost,xMat(i,:));
    NFE=NFE+1;
end

InitPop.xMat=xMat;
InitPop.Costs=Costs;
InitPop.Infeas=Infeas;