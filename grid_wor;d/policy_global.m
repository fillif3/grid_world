function [action] = policy_global(currentPosition,value_function)
    if ismatrix(value_function)
        size=length(value_function);
        current_score=-inf;
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
    elseif ndims(value_function)==3
        possible_actions = [-1,-1;
        -1, 0;
        -1, 1;
        0, 1;
        1, 1;
        1, 0;
        1, -1;
        0, -1];
        [val,idx] = max(value_function(currentPosition(1),currentPosition(2),:));
        action = possible_actions(idx,:);
    end

end