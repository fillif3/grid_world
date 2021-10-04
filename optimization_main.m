number_of_data=629
number_of_rulse = 8;


input=linspace(0,6.28,number_of_data);
input_test = input+input(2)/2;
output=sin(input);
output_test=sin(output);
%plot(input_test,output_test);
fis = mamfis('Name',"tringular");
points_diff = 6.28/number_of_rulse;
left_point = -points_diff;
fis = addInput(fis,[0 6.28],'Name',"input");
for i=1:number_of_rulse
    centroid=left_point+points_diff;
    right_point=centroid+points_diff;
    fis = addMF(fis,"input","trimf",[left_point centroid right_point],'Name',num2str(i));
    left_point=centroid;
end
W = zeros(number_of_data,number_of_rulse);
for i=1:number_of_rulse
    params = fis.Inputs.MembershipFunctions(i).Parameters;
    for j=1:number_of_data
        val1 = max(0,(input(j)-params(1))/(params(2)-params(1)));
        val2 = max(0,1-(input(j)-params(2))/(params(3)-params(2)));
        W(j,i)=min([val1, val2,1]);
    end
end
out_params=zeros(1,number_of_rulse);
p=eye(number_of_rulse)*10000;
for i=1:20
    for j=1:number_of_data
        row = W(j,:);
        p = (eye(number_of_rulse)-p*transpose(row)*inv(1+row*p*transpose(row))*row)*p;
        out_params=out_params+transpose(p*transpose(row)*(output(j)-row*transpose(out_params)));
    end
end
fis = addOutput(fis,[-1 1],'Name',"output");
for i=out_params
    fis = addMF(fis,"output","trimf",[i-0.1, i, i+0.1],'Name',num2str(i));
end
ruleList = ones(number_of_rulse,4)
for i=1:number_of_rulse
    ruleList(i,1:2)=[i,i]
end
fis = addRule(fis,ruleList);

%plotfis(fis_tringular)
%plotmf(fis_tringular,'input',1)