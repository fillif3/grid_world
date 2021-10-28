rng('default')
val = inf;
final_x=[];
xs=zeros(289,10);
fvals=[];
for i=1:1
    starting_points = rand(145+144,1)*pi-pi/2;
    options = optimoptions(@fminunc,'Algorithm','quasi-newton');
    [x,fval,exitflag,output] = fminunc(@func,starting_points,options);
    fvals(end+1)=fval;
    xs(:,i)=x;
    if fval<val
        val=fval;
        final_x=x;
    end
end
z1 = final_x(1:145);
z2 = final_x(146:289);
u = sin(z1)/2+0.5;
v = sin(z2)/2+0.5;