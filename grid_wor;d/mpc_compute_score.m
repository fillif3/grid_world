function cost = mpc_compute_score(inputs,position,targets,fire,grid_size)
number_of_inputs= length(inputs);
horizontal_inputs =inputs(1:number_of_inputs/2);
vertical_inputs =inputs((number_of_inputs/2+1):number_of_inputs);
cost=0;
for i=1:(number_of_inputs/2)
    position=position+[horizontal_inputs(i),vertical_inputs(i)];
    if (ismember(position,fire,'rows'))||(position(1)<1)||(position(2)<1)||(position(1)>grid_size)||(position(2)>grid_size)
        cost=cost+10^6;
    else
        costs = targets-position;
        matrix_costs = costs*transpose(costs);
        cost=cost+min(diag(matrix_costs));
    end
           
end
end