clear all
clc

global PrbInfo
% The function to be minimized
PrbInfo.Fcost='F0'
xOpt_pp=[0	0	0	0	0	0	0	0.05	0	0	0	0	0	0	0.08	0	0	0	0	0	0	0	0	0.1	0	0	0	0]; % Damage scenario
% = = = Initiating Problem
feval(PrbInfo.Fcost,[])

% = = = Initiating Control Parameters
PopSize = 40;   % Population Size
NFE_Max = 5000; % Numbber of Function Evaluations

% = = = Running
NumRuns = 20;
for runID=1:NumRuns
    runID
    InitiatePop;   % Generate "xMat" as initial population and evaluate "Costs" of its members, each individual solution is a row in xMat
    tic;
    h=1;
    [xOpts{runID,h},CostOpts(runID,h),ConvergenceCurves{runID,h},ConvergenceOverIterations{runID,h}]=TLBO_alg(PrbInfo,InitPop,NFE_Max);
    h=2;
    [xOpts{runID,h},CostOpts(runID,h),ConvergenceCurves{runID,h},ConvergenceOverIterations{runID,h}]=OTLBO_alg(PrbInfo,InitPop,NFE_Max);
    h=3;
    [xOpts{runID,h},CostOpts(runID,h),ConvergenceCurves{runID,h},ConvergenceOverIterations{runID,h}]=TLBOAISt_alg(PrbInfo,InitPop,NFE_Max);
    h=4;
    [xOpts{runID,h},CostOpts(runID,h),ConvergenceCurves{runID,h},ConvergenceOverIterations{runID,h}]=TLBOAISs_alg(PrbInfo,InitPop,NFE_Max);
    h=5;
    [xOpts{runID,h},CostOpts(runID,h),ConvergenceCurves{runID,h},ConvergenceOverIterations{runID,h}]=PSOTCHR_alg(PrbInfo,InitPop,NFE_Max);
    toc
end

% = = = Post processing
CostOpts
Best=min(CostOpts)'; Mean=mean(CostOpts)'; SD=std(CostOpts)';
table(Best,Mean,SD)

close all
hold
h=1;
[~,runID_Best]=min(CostOpts(:,h));
xOpt1=xOpts{runID_Best,h};
[Cost,Infeasibility]=feval(PrbInfo.Fcost,xOpt1)
p1 = plot(ConvergenceCurves{runID_Best,h});xlabel('NFE');ylabel('ElitistCost');title(PrbInfo.Fcost);
p1.LineWidth = 2;
h=2;
[~,runID_Best]=min(CostOpts(:,h));
xOpt2=xOpts{runID_Best,h};
[Cost,Infeasibility]=feval(PrbInfo.Fcost,xOpt2)
p2 = plot(ConvergenceCurves{runID_Best,h});xlabel('NFE');ylabel('ElitistCost');title(PrbInfo.Fcost);
p2.LineWidth = 2;
h=3;
[~,runID_Best]=min(CostOpts(:,h));
xOpt3=xOpts{runID_Best,h};
[Cost,Infeasibility]=feval(PrbInfo.Fcost,xOpt3)
p3 = plot(ConvergenceCurves{runID_Best,h});xlabel('NFE');ylabel('ElitistCost');title(PrbInfo.Fcost);
p3.LineWidth = 2;
h=4;
[~,runID_Best]=min(CostOpts(:,h));
xOpt4=xOpts{runID_Best,h};
[Cost,Infeasibility]=feval(PrbInfo.Fcost,xOpt4)
p4 = plot(ConvergenceCurves{runID_Best,h});xlabel('NFE');ylabel('ElitistCost');title(PrbInfo.Fcost);
p4.LineWidth = 2;
h=5;
[~,runID_Best]=min(CostOpts(:,h));
xOpt5=xOpts{runID_Best,h};
[Cost,Infeasibility]=feval(PrbInfo.Fcost,xOpt5)
p5 = plot(ConvergenceCurves{runID_Best,h});xlabel('NFE');ylabel('ElitistCost');title(PrbInfo.Fcost);
p5.LineWidth = 2;
legend('TLBO','OTLBO','TLBOAISt','TLBOAISs','PSOTCHR')
figure;
bar(1 : numel(xOpt_pp),[xOpt_pp; xOpt1]); xlabel('Number of Element'); ylabel('Damage Coefficient'); set(gca, 'XTick', [1:1:numel(xOpt_pp)]); ylim([0,1]);set(gca, 'fontsize',8)
legend('Actual Damage','Predicted Damage(TLBO)')
figure;
bar(1 : numel(xOpt_pp),[xOpt_pp; xOpt2]); xlabel('Number of Element'); ylabel('Damage Coefficient'); set(gca, 'XTick', [1:1:numel(xOpt_pp)]); ylim([0,1]);set(gca, 'fontsize',8)
legend('Actual Damage','Predicted Damage(OTLBO)')
figure;
bar(1 : numel(xOpt_pp),[xOpt_pp; xOpt3]); xlabel('Number of Element'); ylabel('Damage Coefficient'); set(gca, 'XTick', [1:1:numel(xOpt_pp)]); ylim([0,1]);set(gca, 'fontsize',8)
legend('Actual Damage','Predicted Damage(TLBOAISt)')
figure;
bar(1 : numel(xOpt_pp),[xOpt_pp; xOpt4]); xlabel('Number of Element'); ylabel('Damage Coefficient'); set(gca, 'XTick', [1:1:numel(xOpt_pp)]); ylim([0,1]);set(gca, 'fontsize',8)
legend('Actual Damage','Predicted Damage(TLBOAISs)')
figure;
bar(1 : numel(xOpt_pp),[xOpt_pp; xOpt5]); xlabel('Number of Element'); ylabel('Damage Coefficient'); set(gca, 'XTick', [1:1:numel(xOpt_pp)]); ylim([0,1]);set(gca, 'fontsize',8)
legend('Actual Damage','Predicted Damage(PSOTCHR)')
