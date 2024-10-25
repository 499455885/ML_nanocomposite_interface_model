NN=6;
N_mcs=NN*NN*NN;d=3;
lbNN=lb;ubNN=ub;lbNN(2:4)=[];ubNN(2:4)=[];
muNN=(lbNN+ubNN)/2;sigmaNN=((ubNN-lbNN).^2/12).^0.5;
probdataNN= [lbNN.',ubNN.',1*ones(d,1),muNN.',sigmaNN.'];  

x1=linspace(lbNN(1),ubNN(1),NN);
x2=linspace(lbNN(2),ubNN(2),NN);
x3=linspace(lbNN(3),ubNN(3),NN);

[X,Y,Z]=meshgrid(x1,x2,x3);
iii=0;
for i=1:NN
    for j=1:NN
        for k=1:NN
            iii=iii+1;
              x(iii,:)=[X(i,j,k),Y(i,j,k),Z(i,j,k)];
        end
    end
end
xNN=[x(:,1),repmat([20,7,3.75],N_mcs,1),x(:,2),x(:,3)];
for i=1:d
u(:,i)=(x(:,i)-lbNN(i))/(ubNN(i)-lbNN(i));
end
[YmNN,YvarNN]=uq_evalModel(xNN);
max(YvarNN)

figure (2)
scatter3(u(:,1),u(:,2),u(:,3))
