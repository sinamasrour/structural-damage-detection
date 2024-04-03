% Fixing out-of-bound variables to their corresponding bounds
xNewN=min(max(xNew,xLB),xUB);

% Checking candidate solution
[CostN,InfeasN]=feval(PrbInfo.Fcost,xNewN);
NFE=NFE+1;

if CostN<=Costs(xInd) & (InfeasN<=Infeas(xInd))
    % Replacing if better
    vMat(xInd,:)=xNewN-xMat(xInd,:);
    xMat(xInd,:)=xNewN;
    Costs(xInd)=CostN;
    Infeas(xInd)=InfeasN;
    
    % Updating global best-so-far solution
    if CostN<=GbestCost & (InfeasN<=GbestInfeas)
       Gbest=xNewN;
       GbestCost=CostN;
       GbestInfeas=InfeasN;
    end
end
ConvCurve(NFE)=GbestCost;
