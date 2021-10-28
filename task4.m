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
[x,fval,exitflag,output] = linprog(c,[],[],Aeq,beq,lb,ub);
qin = x(1:number_of_samples);
final_cost = transpose(cost)*(qin-qout(1:1440));
final_cost=final_cost-0.43*sum(qin)




