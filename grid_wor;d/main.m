%clear; clc
hold on
size_of_grid=50;
number_of_targets=10;
numbaer_of_obstacles=50;
type_of_solution = 'fuzzy';



%[robot,targets,fire]=createGrid(size_of_grid,numbaer_of_obstacles,number_of_targets);
createGrid(size_of_grid,1,1);

if strcmp(type_of_solution,'fuzzy')
    fuzzy_solution(robot,targets,fire,number_of_targets,size_of_grid,1)
end
if strcmp(type_of_solution,'markov')
    var=markov_solution(robot,targets,fire,number_of_targets,size_of_grid);
end

plot(targets(:,1),targets(:,2),'g*')
plot(fire(:,1),fire(:,2),'r*')