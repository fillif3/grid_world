function final_value_funcution=markov_value_function(targets,fire,grid_size)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
value_function = zeros(grid_size,grid_size,8);
learning_rate=0.1;
reward=-1;
discount=0.95;
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
    value_function(fire(i,1),fire(i,2),:)=ones(1,8)*(-1000);
end
value_function_helper = value_function;
for steps=1:(ceil(grid_size)*6)
    for i=1:grid_size
        for j=1:grid_size
            for a =1:8
                a_current=possible_actions(a,:);
                val= max(value_function(max(min(grid_size,i+a_current(1)),1),max(min(grid_size,j+a_current(2)),1),:));
                %if val~=0
                %    asd=2
                %end
                value_function_helper(i,j,a)=value_function_helper(i,j,a)+learning_rate*(reward*sum(abs(a_current))+discount*val-value_function_helper(i,j,a));
            end
        end
    end
    value_function=value_function_helper;
    for i=1:number_of_targets(1)
        value_function(targets(i,1),targets(i,2),:)=ones(1,8)*1000;
    end
    for i=1:number_of_fire(1)
        value_function(fire(i,1),fire(i,2),:)=ones(1,8)*(-1000);
    end
end

final_value_funcution=zeros(grid_size,grid_size);
for i=1:grid_size
    for j=1:grid_size
            final_value_funcution(i,j)= max(value_function(i,j,:));
    end
end

end