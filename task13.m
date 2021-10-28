A=[]
B=[]
Aeq = [3.5*365,2.2*365,-1,0;1,1,0,1]
Beq=[8040,10]
func = [250,120,0,0]
[x,fval,exitflag,output] = linprog(func,A,B,Aeq,Beq,[0,0,0,0],[inf,inf,inf,inf])