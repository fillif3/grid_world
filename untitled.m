%clear; clc
hold on
size_of_grid=50;
number_of_targets=10;
numbaer_of_obstacles=50;

%[robot,targets,fire]=createGrid(size_of_grid,numbaer_of_obstacles,number_of_targets);
targets_constraints_values=zeros(number_of_targets,size_of_grid,size_of_grid);
targets_value_function=zeros(number_of_targets,size_of_grid,size_of_grid);
for i=1:number_of_targets
    targets_constraints_values(i,:,:) = compute_constraints(targets(i,:),fire,size_of_grid);
    targets_value_function(i,:,:) = compute_value_function_stohastic(targets(i,:),reshape(targets_constraints_values(i,:,:),size_of_grid,size_of_grid),size_of_grid,fire);
end

new_value_function=zeros(size_of_grid,size_of_grid);
for i = 1:size_of_grid
    for j = 1:size_of_grid
        t=text(i-0.3,j,num2str(max(targets_value_function(:,i,j)),2),'Color','k');
        t.FontSize=8;
    end
end
helper_targets=targets
starting_position=robot
for steps=1:number_of_targets
    for i = 1:size_of_grid
        for j = 1:size_of_grid
            new_value_function(i,j)=max(targets_value_function(:,i,j));
        end
    end
    [traj_x,traj_y,target] = getTrajectoryGlobal(starting_position,helper_targets,50,new_value_function);
    targets_value_function(target,:,:)=[];
    helper_targets(target,:)=[];
    plot(traj_x,traj_y,'b-*')
    starting_position(1)=traj_x(end);
    starting_position(2)=traj_y(end)
end
plot(targets(:,1),targets(:,2),'g*')
plot(fire(:,1),fire(:,2),'r*')


