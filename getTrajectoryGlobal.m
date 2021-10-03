function [traj_x,traj_y] = getTrajectoryGlobal(robotPosition,target,sizemax,value_function)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    traj_x = robotPosition(1);
    traj_y = robotPosition(2);
    i=1
    while 1
        last_position = [traj_x(end),traj_y(end)];
        if (all(last_position==target) || (i==100)) 
            break
        end
        action = policy_global(last_position,target,value_function);
        traj_x(end+1)=traj_x(end)+action(1);
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
        traj_y(end+1)=traj_y(end)+action(2);
        i=i+1;
    end
end