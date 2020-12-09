
%时间间隔
h=0.1;
ts=[0:h:30]; %时间区间

%种群基数
x0=[10,10];

%相对误差为1e-6，绝对误差为1e-9
opt=odeset('reltol',1e-6,'abstol',1e-9);
%5级4阶龙格-库塔公式
[t,x]=ode45(@fun,ts,x0,opt);
plot(t,x(:,1),'r',t,x(:,2),'b','LineWidth',2),grid;
