function action = mpc_next_step(position,targets,fire,size_of_grid,prob,horizon)
options = optimoptions('ga','display','off');
cost_function = @(x)mpc_compute_score(x,position,targets,fire,size_of_grid,prob);
lb = -ones(horizon*2,1);
ub = ones(horizon*2,1);
intcon = 1:(horizon*2);
[x,~] = ga(cost_function,horizon*2,[],[],[],[],lb,ub,[],intcon,options);
action = [x(1),x(horizon+1)];

end