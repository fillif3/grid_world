%clear; clc
hold on
size=50;
[robot,targets,fire]=createGrid(size,100,10);
target=targets(1,:)
constraints_values = compute_constraints(target,fire,size);
value_function = compute_value_function(target,constraints_values,size)



for i = 1:size
    for j = 1:size
        t=text(i-0.3,j,num2str(value_function(i,j),2),'Color','k');
        t.FontSize=8;
    end
end

[traj_x,traj_y] = getTrajectoryGlobal(robot,target,50,value_function);
plot(traj_x,traj_y,'b-*')
plot(target(1),target(2),'g*')
plot(fire(:,1),fire(:,2),'r*')

