NN=7;
N_mcs=NN*NN*NN;d=3;
lbNN=lb;ubNN=ub;

xx(:,1)=linspace(lbNN(1),ubNN(1),NN).';xn(:,1)=(xx(:,1)-lbNN(1))/(ubNN(1)-lbNN(1));
xx(:,2)=linspace(lbNN(2),ubNN(2),NN).';xn(:,2)=(xx(:,2)-lbNN(2))/(ubNN(2)-lbNN(2));
xx(:,3)=linspace(lbNN(3),ubNN(3),NN).';xn(:,3)=(xx(:,3)-lbNN(3))/(ubNN(3)-lbNN(3));
xx(:,4)=linspace(lbNN(4),ubNN(4),NN).';xn(:,4)=(xx(:,4)-lbNN(4))/(ubNN(4)-lbNN(4));
xx(:,5)=linspace(lbNN(5),ubNN(5),NN).';xn(:,5)=(xx(:,5)-lbNN(5))/(ubNN(5)-lbNN(5));
xx(:,6)=linspace(lbNN(6),ubNN(6),NN).';xn(:,6)=(xx(:,6)-lbNN(6))/(ubNN(6)-lbNN(6));

[X,Y]=meshgrid(xx(:,2),xx(:,6));
[Xn,Yn]=meshgrid(xn(:,2),xn(:,6));%rf,VF/ ef,er / rf,thk
iii=0;
for i=1:NN
    for j=1:NN
        iii=iii+1
%         x_sa(iii,:)=[(lbNN(1)+ubNN(1))/2,X(i,j),(lbNN(3)+ubNN(3))/2,(lbNN(4)+ubNN(4))/2,Y(i,j),(lbNN(6)+ubNN(6))/2];
%         x_sa(iii,:)=[(lbNN(1)+ubNN(1))/2,(lbNN(2)+ubNN(2))/2,X(i,j),Y(i,j),(lbNN(5)+ubNN(5))/2,(lbNN(6)+ubNN(6))/2];
        x_sa(iii,:)=[(lbNN(1)+ubNN(1))/2,X(i,j),(lbNN(2)+ubNN(2))/2,(lbNN(5)+ubNN(5))/2,(lbNN(6)+ubNN(6))/2,Y(i,j)];

        x_sa_n(iii,:)=[Xn(i,j),Yn(i,j)];
    end
end

[YmNN,YvarNN]=uq_evalModel(x_sa);

% legend('np','rf','ef','er','VF','thk')

