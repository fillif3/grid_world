function [action] = policy_global(currentPosition,value_function)
    size=length(value_function);
    current_score=0;
    action = [];
    for i=[-1,0,1]
        for j = [-1,0,1]
            score = value_function(max(min(size,currentPosition(1)+i),1),max(min(size,currentPosition(2)+j),1));
            if score>current_score
                action=[i,j];
                current_score=score;
            end

        end
    end
end