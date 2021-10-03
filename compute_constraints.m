function constraints_values= compute_constraints(target,fire,size)
constraints_values=ones(size,size);
for f=transpose(fire)
    for i=1:size
        for j=1:size
            
            distance  = norm(f - [i;j]);
            distance_to_target=norm(target - [i,j]);
            ramp=max([1/distance_to_target,0.3]);
            constraints_values(i,j)=min(constraints_values(i,j),ramp_delay(distance,0,ramp));
        end
    end
end

end