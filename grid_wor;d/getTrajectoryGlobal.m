function [traj_x,traj_y,final_target] = getTrajectoryGlobal(robotPosition,targets,sizemax,value_function)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    traj_x = robotPosition(1);
    traj_y = robotPosition(2);
    number_of_targets=size(targets);
    number_of_targets=number_of_targets(1);
    i=1;
    while 1
        last_position = [traj_x(end),traj_y(end)];
        for j=1:number_of_targets
            if (all(last_position==targets(j,:)) || (i==100)) 
                final_target=j;
                return
            end
        end
        action = policy_global(last_position,value_function);
        traj_x(end+1)=traj_x(end)+action(1);
        traj_y(end+1)=traj_y(end)+action(2);
        if traj_x(end)<1
            traj_x(end)=1;
        end
        if traj_x(end)>sizemax
            traj_x(end)=sizemax;
        end
        if traj_y(end)<1
            traj_y(end)=1;
        end
        if traj_y(end)>sizemax
            traj_y(end)=sizemax;
        end
        
        i=i+1;
    end
end