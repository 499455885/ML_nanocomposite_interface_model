clear all;clc;uqlab
f1=xlsread('Opt_new_0816.xlsx',2,'A2:G301');
f2=xlsread('Opt_new_0816.xlsx',3,'A2:G301');
f=[f1;f2];
d=6;nt=600;nv=size(f,1)-nt;Nmodel=nt;
lb=[2,10,4,2.5,0.00147,5];ub=[10,30,10,5,0.0314,31];%13.2
VT=repmat({'Uniform'},1,d);
for ii = 1:d
    InputOpts.Marginals(ii).Type = VT{ii};
    InputOpts.Marginals(ii).Parameters = [lb(ii),ub(ii)]; 
end
myInput = uq_createInput(InputOpts);
MetaOpts.ExpDesign.X =f(1:Nmodel,1:d);
MetaOpts.ExpDesign.Y=f(1:Nmodel,d+1);
MetaOpts.Type='Metamodel';
MetaOpts.MetaType='PCK';
MetaOpts.Mode = 'sequential';
mySPCK = uq_createModel(MetaOpts);% 

f3=xlsread('Opt_new_0816.xlsx',4,'C2:G13');

lb=5;ub=31;nD=1;
x1=10;%or x1=5 or x1=2
Npop = 100;% Number of search agents
Max_it = 50;% Maximum number of iterations
for i=1:size(f3,1)
    INP=f3(i,1:4);
fobj=@(x)abs(uq_evalModel(mySPCK,[x1,INP,x])-f3(i,5));

[Xin,ytao,~]=MPA(Npop,Max_it,lb,ub,1,fobj);%

ff1(i)=uq_evalModel(mySPCK,[x1,INP,Xin]);

err1(i)=(ff1(i)-f3(i,5))/f3(i,5);
results(i,:)=Xin;
end

