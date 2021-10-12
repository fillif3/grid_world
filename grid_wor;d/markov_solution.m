function var=markov_solution(robot,targets,fire,number_of_targets,size_of_grid)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
var=zeros(50,50,8);
helper_targets=targets;
starting_position=robot;
for steps=1:number_of_targets
    value_function = markov_value_function(helper_targets,fire,size_of_grid);
    var(:,:,steps) = value_function;
    [traj_x,traj_y,target] = getTrajectoryGlobal(starting_position,helper_targets,50,value_function);
    helper_targets(target,:)=[];
    plot(traj_x,traj_y,'b-*')
    plot(targets(:,1),targets(:,2),'g*')
    plot(fire(:,1),fire(:,2),'r*')
    starting_position(1)=traj_x(end);
    starting_position(2)=traj_y(end);
end
end