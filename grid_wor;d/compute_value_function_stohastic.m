function value_function = compute_value_function_stohastic(target,constraints_values,size,fire,probability)
main_action_probability=probability;
close_actions_probability=(1-probability)/2;
discount=0.99;
value_function = zeros(size,size);
value_function(target(1),target(2))=constraints_values(target(1),target(2));
value_function_helper = value_function;
possible_actions = [-1,-1;
        -1, 0;
        -1, 1;
        0, 1;
        1, 1;
        1, 0;
        1, -1;
        0, -1];
for steps=1:ceil(size)
    for i=1:size
        for j=1:size
            if i==target(1) && j==target(2)
                continue
            end
         

            a_current = possible_actions(8,:);
            a_pre = possible_actions(7,:);
            val=value_function(i,j);
            for step=1:8
                a_next = possible_actions(step,:);
                score_pre = value_function(max(min(size,i+a_pre(1)),1),max(min(size,j+a_pre(2)),1));
                score_next = value_function(max(min(size,i+a_next(1)),1),max(min(size,j+a_next(2)),1));
                score_current = value_function(max(min(size,i+a_current(1)),1),max(min(size,j+a_current(2)),1));
                score = score_current*main_action_probability+(score_next+score_pre)*close_actions_probability;
                val=max(val,((1-(1-discount)*sum(abs(a_current))))*score);
                a_pre=a_current;
                a_current=a_next;
            end
            
            value_function_helper(i,j)=min([val,constraints_values(i,j)]);
        end
    end
    value_function=value_function_helper;
    for f=transpose(fire)
        value_function(f(1),f(2))=0;
    end
end

end