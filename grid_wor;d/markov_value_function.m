function value_function=markov_value_function(targets,fire,grid_size,main_action_probability)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
value_function = zeros(grid_size,grid_size,8);
learning_rate=0.1;
rewards = ones(grid_size);
target_size=size(targets);
for i=1:target_size(1)

    rewards=min(compute_constraints(targets(i,:),fire,grid_size),rewards);
end
rewards=rewards.^2;
rewards=(rewards-1.1)*10;
discount=0.95;
close_actions_probability = (1-main_action_probability)/2;
number_of_targets = size(targets);
number_of_fire=size(fire);
possible_actions = [-1,-1;
        -1, 0;
        -1, 1;
        0, 1;
        1, 1;
        1, 0;
        1, -1;
        0, -1];
for i=1:number_of_targets(1)
    value_function(targets(i,1),targets(i,2),:)=ones(1,8)*1000;
end
for i=1:number_of_fire(1)
    value_function(fire(i,1),fire(i,2),:)=ones(1,8)*(-100000);
end
value_function_helper = value_function;
for steps=1:(ceil(grid_size)*6)
    for i=1:grid_size
        for j=1:grid_size
            a_current = possible_actions(8,:);
            a_pre = possible_actions(7,:);
            for a =1:8
                a_next = possible_actions(a,:);
                score_pre = max(value_function(max(min(grid_size,i+a_pre(1)),1),max(min(grid_size,j+a_pre(2)),1),:));
                score_next = max(value_function(max(min(grid_size,i+a_next(1)),1),max(min(grid_size,j+a_next(2)),1),:));
                score_current = max(value_function(max(min(grid_size,i+a_current(1)),1),max(min(grid_size,j+a_current(2)),1),:));
                val = score_current*main_action_probability+(score_next+score_pre)*close_actions_probability;

                %if (score_pre<0 ||score_current<0 ||score_next<0) && steps>100 
                %    asd=2
                %end
                action_index=a-1;
                if action_index==0
                    action_index=8;
                end
                value_function_helper(i,j,action_index)=value_function(i,j,action_index)+learning_rate*(rewards(i,j)*(sum(abs(a_current)))+discount*val-value_function(i,j,action_index));
                a_pre=a_current;
                a_current=a_next;
            end
        end
    end
    value_function=value_function_helper;
    for i=1:number_of_targets(1)
        value_function(targets(i,1),targets(i,2),:)=ones(1,8)*1000;
    end
    for i=1:number_of_fire(1)
        value_function(fire(i,1),fire(i,2),:)=ones(1,8)*(-100000);
    end
end



end