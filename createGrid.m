function [robotPosition,targets,obstacles] = createGrid(size,number_of_obstacles,number_of_targets)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i=1:size
    plot([i-0.5,i-0.5],[0.5,size+0.5],Color='k')
    plot([0.5,size+0.5],[i-0.5,i-0.5],Color='k')
end
obstacles=  randi(size,number_of_obstacles,2);
flag = 1;
while flag
    flag=0;
    robotPosition = randi(size,1,2);
    for i =1:number_of_obstacles
        if obstacles(i,:)==robotPosition
            flag=1;
        end
    end
end
targets=zeros(number_of_targets,2);
j=1;
while targets(number_of_targets,2)==0
    target = randi(size,1,2);
    flag=1;
    for i =1:number_of_obstacles
        if obstacles(i,:)==target
            flag=0;
            break
        end
    end
    if flag
        targets(j,:) = target;
        j=j+1;
    end
end