function [action] = policy_global_stochastic(currentPosition,value_function)

    main_action_probability=0.6;
    close_actions_probability=0.2;

    size=length(value_function);
    current_score=0;
    possible_actions = [-1,-1;
        -1, 0;
        -1, 1;
        0, 1;
        1, 1;
        1, 0;
        1, -1;
        0, -1];
    action = [];
    for i=1:8
        previous_action=i-1;
        if previous_action==0
            previous_action=8;
        end
        next_action=i+1;
        if next_action==9
            next_action=1;
        end
        a_pre = possible_actions(previous_action,:);
        a_next = possible_actions(next_action,:);
        a_current = possible_actions(i,:);
        score_pre = value_function(max(min(size,currentPosition(1)+a_pre(1)),1),max(min(size,currentPosition(2)+a_pre(2)),1));
        score_next = value_function(max(min(size,currentPosition(1)+a_next(1)),1),max(min(size,currentPosition(2)+a_next(2)),1));
        score_current = value_function(max(min(size,currentPosition(1)+a_current(1)),1),max(min(size,currentPosition(2)+a_current(2)),1));
        score = score_current*main_action_probability+(score_next+score_pre)*close_actions_probability;
        if score>current_score
            action=a_current;
            current_score=score;
        end
    end
end