function cost = mpc_compute_score(inputs,position,targets,fire,grid_size,probability)
main_action_probability=probability;
close_actions_probability=(1-probability)/2;
if main_action_probability==1
    probalities=1;
    number_of_actions=1;
else
    probalities=[main_action_probability,close_actions_probability,close_actions_probability];
    number_of_actions=3;
end
old_probabilty_distrbution_positions=[position,1,1];
number_of_inputs= length(inputs);
targets_helper={targets};
horizontal_inputs =inputs(1:number_of_inputs/2);
vertical_inputs =inputs((number_of_inputs/2+1):number_of_inputs);
cost=0;
for i=1:(number_of_inputs/2)
    if number_of_actions==3
        actions=get_actions_with_probablity([horizontal_inputs(i),vertical_inputs(i)]);
    else
        actions=[horizontal_inputs(i),vertical_inputs(i)];
    end
    new_probabilty_distrbution_positions=zeros(number_of_actions^i,4);
    for j=1:(number_of_actions^(i-1))
        for k=1:number_of_actions
            new_probabilty_distrbution_positions((j-1)*number_of_actions+k,:)=[old_probabilty_distrbution_positions(j,1)+actions(k,1),...
                old_probabilty_distrbution_positions(j,2)+actions(k,2),...
                old_probabilty_distrbution_positions(j,3)*probalities(k),...
                old_probabilty_distrbution_positions(j,4)];
        end
    end
    old_probabilty_distrbution_positions=new_probabilty_distrbution_positions;
    j=0;
    for possible_postisions=transpose(old_probabilty_distrbution_positions)
        possible_positions_traposed=transpose(possible_postisions(1:2));
        j=j+1;

        if possible_postisions(1)<1
            possible_positions_traposed(1)=1;
        end
        if possible_postisions(2)<1
            possible_positions_traposed(2)=1;
        end
        if possible_postisions(1)>grid_size
            possible_positions_traposed(1)=grid_size;
        end
        if possible_postisions(1)>grid_size
            possible_positions_traposed(2)=grid_size;
        end
        if (ismember(possible_positions_traposed,fire,'rows'))
            cost=cost+10^6*possible_postisions(3);
        else
            costs = targets_helper{possible_postisions(4)}-possible_positions_traposed(1:2);
            matrix_costs = costs*transpose(costs);
            cost=cost+(min(diag(matrix_costs))+(abs(horizontal_inputs(i))+abs(vertical_inputs(i)))^2)*possible_postisions(3);
        end
        current_targets=targets_helper{possible_postisions(4)};
        number_of_targets=size(current_targets);
        for l=1:number_of_targets(1)
            if possible_positions_traposed==current_targets(l,:)
                cost=cost-1000*possible_postisions(3);
                current_targets(l,:)=[];
                targets_helper{end+1}=current_targets;
                new_probabilty_distrbution_positions(j,4)=length(targets_helper);
                break
            end
        end
    end
           
end
end