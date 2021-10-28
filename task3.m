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
A=[];
b=[];
[x,fval,exitflag,output] = quadprog(H,c,[],[],[],[],[0,0],[2,inf]);