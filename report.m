%% 1.2 
clc; clear;
A=[];
B=[];
Aeq = [1,1,1,0;250,120,0,1];
Beq=[10,2020];
func = [-3.5,-2.2 0 0];
[x,fval,exitflag,output] = linprog(func,A,B,Aeq,Beq,[0,0,0,0],[inf,inf,inf,inf])
%% 1.3
clc; clear;
A=[];
B=[];
Aeq = [3.5*365,2.2*365,-1,0;1,1,0,1];
Beq=[8040,10];
func = [250,120,0,0];
[x,fval,exitflag,output] = linprog(func,A,B,Aeq,Beq,[0,0,0,0],[inf,inf,inf,inf])
%% 3
clc; clear;
tab=readtable("measurements21.csv");
Temperature=tab.T;
Temperature_amb = tab.TAmb;
qin=tab.qIn;
qout = tab.qOut;
number_of_samples = length(Temperature);
Y=Temperature(2:number_of_samples)-Temperature(1:number_of_samples-1);
Sigma=zeros(number_of_samples-1,2);
Sigma(:,1) = Temperature_amb(1:number_of_samples-1)- Temperature(1:number_of_samples-1);
Sigma(:,2) = qin(1:number_of_samples-1)- qout(1:number_of_samples-1);
H = transpose(Sigma)*Sigma;     
c = -transpose(Y)*Sigma;
[x,fval,exitflag,output] = quadprog(H,c,[],[],[],[],[0,0],[2,inf])
%% 4
clc; clear;
tab=readtable("measurements21.csv");
Temperature_starting=23.3;
Temperature_amb = tab.TAmb;
qout = tab.qOut;
number_of_samples = 1440;
cost=tab.price(1:number_of_samples);
delta_t=60;
a1=0.0252/60;
a2 = 0.1249/60;

Aeq=zeros(number_of_samples,number_of_samples*2);
Aeq(1,1) = -delta_t*a2;
Aeq(1,number_of_samples+1)=1;
beq = zeros(number_of_samples,1);
beq(1) = delta_t*a1*Temperature_amb(1)-delta_t*a2*qout(1)-(delta_t*a1-1)*Temperature_starting;
for i=2:number_of_samples
    Aeq(i,i) = -delta_t*a2;
    Aeq(i,number_of_samples+i) = 1;
    Aeq(i,number_of_samples+i-1) = (delta_t*a1-1);
    beq(i) = delta_t*a1*Temperature_amb(i)-delta_t*a2*qout(i);
end
lb = zeros(number_of_samples*2,1);
lb(number_of_samples+1:end) = -Inf(number_of_samples,1);
ub = ones(number_of_samples*2,1)*125;
ub(number_of_samples+1:end) = ones(number_of_samples,1)*90;

c = cost-0.43;
c(number_of_samples+1:number_of_samples*2)=zeros(number_of_samples,1);
[x,fval,exitflag,output] = linprog(c,[],[],Aeq,beq,lb,ub)
qin = x(1:number_of_samples);
final_cost = transpose(cost)*(qin-qout(1:1440));
final_cost=final_cost-0.43*sum(qin)