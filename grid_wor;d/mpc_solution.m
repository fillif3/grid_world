function var=mpc_solution(robot,targets,fire,size_of_grid,prob)
var=zeros(size_of_grid,size_of_grid,8);
helper_targets=targets;
starting_position=robot;
steps=1;
while 1
    action = mpc_next_step(helper_targets,fire,size_of_grid,prob,3);
    %var(:,:,steps) = value_function;
    traj_x(end+1)=traj_x(end)+action(1);
    traj_y(end+1)=traj_y(end)+action(2);
    idx=[]
    number_of_targets_in_loop=size(helper_targets)
    for i=1:number_of_targets_in_loop(1)
        if (target(i,1) == traj_x(end))&&(target(i,2) == traj_y(end))
            idx(end+1) = i
            break
        end
    end
    for i=idx
        helper_targets(i,:)=[];
    end
    if isempty(helper_targets)
        break
    end

    helper_targets(target,:)=[];

    starting_position(1)=traj_x(end);
    starting_position(2)=traj_y(end);
    if mod(steps,15)==0
        plot(traj_x,traj_y,'b-*')
    end
    steps=steps+1
end
plot(traj_x,traj_y,'b-*')
end
