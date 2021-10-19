function action = mpc_next_step(position,targets,fire,size_of_grid,prob,horizon)
options = optimoptions('surrogateopt','MaxFunctionEvaluations',50,'PlotFcn',[]);
cost_function = @(x)mpc_compute_score(x,position,targets,fire,size_of_grid);
inputs = zeros(horizon*2,1);
lb = -ones(horizon*2,1);
ub = ones(horizon*2,1);
intcon = 1:(horizon*2);
[x,fval] = surrogateopt(cost_function,lb,ub,intcon,options);
action = [x(1),x(horizon+1)];
end