%clear; clc


rng(1,'philox')
hold on
size_of_grid=50;
number_of_targets=10;
numbaer_of_obstacles=10;
type_of_solution = 'markov';
prob=1;
%[robot,targets,fire]=createGrid(size_of_grid,numbaer_of_obstacles,number_of_targets);
   createGrid(size_of_grid,1,1);
for i ={'c','xm','ob'}
    tic
    if strcmp(type_of_solution,'fuzzy')
        fuzzy_solution(robot,targets,fire,number_of_targets,size_of_grid,prob,i{1},0)
    end
    toc
    prob = prob -0.2;
end
prob=1;
for i ={'c','xm','ob'}
    tic
    if strcmp(type_of_solution,'markov')
        var=markov_solution(robot,targets,fire,number_of_targets,size_of_grid,prob,i{1});
    end
    toc
    prob = prob -0.2;
end
prob=1;
for i ={'c','xm','ob'}
    tic
    if strcmp(type_of_solution,'MPC')
        var=mpc_solution(robot,targets,fire,size_of_grid,prob,5,i{1});
    end
    toc
    prob = prob -0.2;
end

plot(targets(:,1),targets(:,2),'g*')
plot(fire(:,1),fire(:,2),'r*')