function [action] = policy(currentPosition,target,obstacles)
    number_of_obstacles= length(obstacles);
    
    fis = readfis('untitled2');
    helper=target-currentPosition;
    direction_to_target = atan2(helper(2),helper(1));
    current_score=-1;
    action = [];
    for i=[-1,0,1]
        for j = [-1,0,1]
            if i==0 && j==0
                continue
            end
            direction_of_action = atan2(j,i);
            differnce_between_directions = direction_to_target-direction_of_action;
            if differnce_between_directions<-3.14
                differnce_between_directions=differnce_between_directions+6.28;
            end
            if differnce_between_directions>3.14
                differnce_between_directions=differnce_between_directions-6.28;
            end
            min_dist=2.99;
            %current_checked_position=[currentPosition(1)]
            index=0;
            for k=1:number_of_obstacles
                dist = sqrt((obstacles(k,1)-(i+currentPosition(1)))^2+(obstacles(k,2)-(j+currentPosition(2)))^2);
                if dist<min_dist
                    min_dist=dist;
                    index=k;
                end
            end
            score = evalfis(fis,[differnce_between_directions,min_dist]);
            if score>current_score
                action=[i,j];
                current_score=score;
            end

        end
    end
end