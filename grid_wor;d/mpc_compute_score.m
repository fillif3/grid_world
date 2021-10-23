function cost = mpc_compute_score(inputs,position,targets,fire,grid_size,probability)
main_action_probability=probability;
close_actions_probability=(1-probability)/2;
probalities=[main_action_probability,close_actions_probability,close_actions_probability];
old_probabilty_distrbution_positions=[position,1];
number_of_inputs= length(inputs);
targets_helper=targets;
horizontal_inputs =inputs(1:number_of_inputs/2);
vertical_inputs =inputs((number_of_inputs/2+1):number_of_inputs);
cost=0;
for i=1:(number_of_inputs/2)
    actions=get_actions_with_ptoablity([horizontal_inputs(i),vertical_inputs(i)]);
    new_probabilty_distrbution_positions=zeros(3^i,3);
    for j=1:((i-1)^3)
        for k=1:3
            new_probabilty_distrbution_positions=[old_probabilty_distrbution_positions(j,1)+actions(k,1),...
                old_probabilty_distrbution_positions(j,2)+actions(k,2),...
                old_probabilty_distrbution_positions(j,3)*probalities(k)]
        end
    end
    old_probabilty_distrbution_positions=new_probabilty_distrbution_positions;
    if (ismember(position,fire,'rows'))||(position(1)<1)||(position(2)<1)||(position(1)>grid_size)||(position(2)>grid_size)
        cost=cost+10^6;
    else
        costs = targets_helper-position;
        matrix_costs = costs*transpose(costs);
        cost=cost+min(diag(matrix_costs))+(horizontal_inputs(i)+vertical_inputs(i))^2;
    end
    number_of_targets=size(targets_helper);
    for i=1:length(number_of_targets(2))\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ co zrobić z targetami
        if position==targets_helper(:,i)
            cost=cost-1000;
            targets_helper(:,i)=[];
            break
        end
    end
           
end
end