function value_function = compute_value_function(target,constraints_values,size)
value_function = zeros(size,size);
value_function(target(1),target(2))=constraints_values(target(1),target(2));
value_function_helper = value_function;
for steps=1:ceil(size)
    for i=1:size
        for j=1:size
            left = max(1,i-1);
            right = min(size,i+1);
            up = min(size,j+1);
            down = max(1,j-1);
            val=0;
            for i2=left:right
                for j2=down:up
                    val=max(val,(1-0.01*sum(abs([i2-i,j2-j])))*value_function(i2,j2));
                end
            end
            value_function_helper(i,j)=min([val,constraints_values(i,j)]);
        end
    end
    value_function=value_function_helper;
end

end