function out = get_actions_with_probablity(action)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if action(1)==0
    if action(2)==0
        out=[action;action;action];
    else
        out=[action;[-1,action(2)];[1,action(2)]];
    end
else
    if action(2)==0
        out=[action;[action(1),-1];[action(1),1]];
    else
        out=[action;[action(1),0];[0,action(2)]];
    end
end