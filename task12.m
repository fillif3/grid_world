A=[]
B=[]
Aeq = [1,1,1,0;250,120,0,1]
Beq=[10,2020]
func = [-3.5,-2.2 0 0]
[x,fval,exitflag,output] = linprog(func,A,B,Aeq,Beq,[0,0,0,0],[inf,inf,inf,inf])