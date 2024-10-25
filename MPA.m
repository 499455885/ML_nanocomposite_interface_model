
%_________________________________________________________________________
%  Marine Predators Algorithm source code (Developed in MATLAB R2015a)
%
%  programming: Afshin Faramarzi & Seyedali Mirjalili
%
% paper:
%  A. Faramarzi, M. Heidarinejad, S. Mirjalili, A.H. Gandomi, 
%  Marine Predators Algorithm: A Nature-inspired Metaheuristic
%  Expert Systems with Applications, 2020

%_________________________________________________________________________
function [xposbest,fvalbest,Curve]=MPA(Npop,Max_it,lb,ub,nD,fobj)

% disp('Marine Predators Algorithm (MPA) is optimizing your problem');
xposbest=zeros(1,nD);
fvalbest=inf;
Curve=zeros(1,Max_it);
stepsize=zeros(Npop,nD);
fitness=inf(Npop,1);
if size(ub,2) == 1
    lb = lb*ones(1,nD); ub = ub*ones(1,nD);
end
Prey=rand(Npop,1).*(ub-lb)+lb;


Xmin=repmat(ones(1,nD).*lb,Npop,1);
Xmax=repmat(ones(1,nD).*ub,Npop,1);

Iter=1;
FADs=0.2;
P=0.5;
while Iter<=Max_it
    %------------------- Detecting top predator -----------------
    for i=1:size(Prey,1)
        
        Flag4ub=Prey(i,:)>ub;
        Flag4lb=Prey(i,:)<lb;
        Prey(i,:)=(Prey(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        fitness(i,1)=fobj(Prey(i,:));
        
        if fitness(i,1)<fvalbest
            fvalbest=fitness(i,1);
            xposbest=Prey(i,:);
        end
    end
    
    %------------------- Marine Memory saving -------------------
    
    if Iter==1
        fit_old=fitness;    Prey_old=Prey;
    end
    
    Inx=(fit_old<fitness);
    Indx=repmat(Inx,1,nD);
    Prey=Indx.*Prey_old+~Indx.*Prey;
    fitness=Inx.*fit_old+~Inx.*fitness;
    
    fit_old=fitness;    Prey_old=Prey;
    
%     %------------------------------------------------------------
%     Elite=repmat(xposbest,Npop,1);  %(Eq. 10)
%     CF=(1-Iter/Max_it)^(2*Iter/Max_it);
%     % RL=0.05*levy(Npop,nD,1.5);   %Levy random number vector
%     beta=3/2;
%     sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta); % Levy flight
%     u=randn(size(stepsize)).*sigma;
%     v=randn(size(stepsize));
%     S=u./abs(v).^(1/beta);
%     RL = 0.05*S;
%     RB=randn(Npop,nD);          %Brownian random number vector
%     for i=1:size(Prey,1)
%         for j=1:size(Prey,2)
%             R=rand();
%             %------------------ Phase 1 (Eq.12) -------------------
%             if Iter<Max_it/3
%                 stepsize(i,j)=RB(i,j)*(Elite(i,j)-RB(i,j)*Prey(i,j));
%                 Prey(i,j)=Prey(i,j)+P*R*stepsize(i,j);
%                 %--------------- Phase 2 (Eqs. 13 & 14)----------------
%             elseif Iter>Max_it/3 && Iter<2*Max_it/3
%                 if i>size(Prey,1)/2
%                     stepsize(i,j)=RB(i,j)*(RB(i,j)*Elite(i,j)-Prey(i,j));
%                     Prey(i,j)=Elite(i,j)+P*CF*stepsize(i,j);
%                 else
%                     stepsize(i,j)=RL(i,j)*(Elite(i,j)-RL(i,j)*Prey(i,j));
%                     Prey(i,j)=Prey(i,j)+P*R*stepsize(i,j);
%                 end
%                 %----------------- Phase 3 (Eq. 15)-------------------
%             else
%                 stepsize(i,j)=RL(i,j)*(RL(i,j)*Elite(i,j)-Prey(i,j));
%                 Prey(i,j)=Elite(i,j)+P*CF*stepsize(i,j);
%             end
%         end
%     end

    %--------------------update positions------------------------
    Elite=repmat(xposbest,Npop,1);  %(Eq. 10)
    CF=(1-Iter/Max_it)^(2*Iter/Max_it);
    beta=3/2;
    sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta); % Levy flight
    u=randn(Npop,nD).*sigma;
    v=randn(Npop,nD);
    S=u./abs(v).^(1/beta);
    RL = 0.05*S; % RL=0.05*levy(Npop,nD,1.5);   % Levy random number vector
    RB = randn(Npop,nD);          % Brownian random number vector
    if Iter<Max_it/3
        stepsize = RB.*(Elite-RB.*Prey);
        Prey = Prey+P*rand(Npop,nD).*stepsize;
    elseif Iter >= Max_it/3 && Iter < 2*Max_it/3
        if i > Npop/2
            stepsize = RB.*(RB.*Elite-Prey);
            Prey = Elite+P*CF*stepsize;
        else
            stepsize = RL.*(RL.*Elite-Prey);
            Prey = Prey + P*rand(Npop,nD).*stepsize;
        end
    else
        stepsize = RL.*(RL.*Elite-Prey);
        Prey = Elite+P*CF*stepsize;
    end
    
    
    %------------------ Detecting top predator ------------------
    for i=1:size(Prey,1)
        
        Flag4ub=Prey(i,:)>ub;
        Flag4lb=Prey(i,:)<lb;
        Prey(i,:)=(Prey(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        fitness(i,1)=fobj(Prey(i,:));
        
        if fitness(i,1)<fvalbest
            fvalbest=fitness(i,1);
            xposbest=Prey(i,:);
        end
    end
    
    %---------------------- Marine Memory saving ----------------
    
    if Iter==1
        fit_old=fitness;    Prey_old=Prey;
    end
    
    Inx=(fit_old<fitness);
    Indx=repmat(Inx,1,nD);
    Prey=Indx.*Prey_old+~Indx.*Prey;
    fitness=Inx.*fit_old+~Inx.*fitness;
    
    fit_old=fitness;    Prey_old=Prey;
    %---------- Eddy formation and FADs? effect (Eq 16) -----------
    
    if rand()<FADs
        U=rand(Npop,nD)<FADs;
        Prey=Prey+CF*((Xmin+rand(Npop,nD).*(Xmax-Xmin)).*U);
    else
        r=rand();  Rs=size(Prey,1);
        stepsize=(FADs*(1-r)+r)*(Prey(randperm(Rs),:)-Prey(randperm(Rs),:));
        Prey=Prey+stepsize;
    end
    
    
    Curve(Iter)=fvalbest;
    Iter=Iter+1;
end

end
