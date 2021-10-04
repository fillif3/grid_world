number_of_data=627
number_of_rulse = 6;
types_of_membership_function = {'tringular'};
%types_of_membership_function = {'gauss'};
gradient_decent_flag=true

for type_mf = types_of_membership_function

    input=linspace(0,6.27,number_of_data);
    input_test = input+input(2)/2;
    output=sin(input);
    output_test=sin(output);
    %plot(input_test,output_test);
    fis = mamfis('Name',"sinus_fis");
    fis.AndMethod='prod'
    points_diff = 6.28/(number_of_rulse-1);
    left_point = -points_diff;
    fis = addInput(fis,[0 6.28],'Name',"input");
    for i=1:number_of_rulse
        centroid=left_point+points_diff;
        right_point=centroid+points_diff;
        if strcmp(type_mf,'tringular')
            fis = addMF(fis,"input","trimf",[left_point centroid right_point],'Name',num2str(i));
        elseif strcmp(type_mf,'gauss')
            fis = addMF(fis,"input","gaussmf",[0.4 centroid],'Name',num2str(i));
        end
        left_point=centroid;
    end
    W = zeros(number_of_data,number_of_rulse);
    for i=1:number_of_rulse
        params = fis.Inputs.MembershipFunctions(i).Parameters;
        for j=1:number_of_data
            if strcmp(type_mf,'tringular')
                val1 = max(0,(input(j)-params(1))/(params(2)-params(1)));
                val2 = max(0,1-(input(j)-params(2))/(params(3)-params(2)));
                W(j,i)=min([val1, val2,1]);
            elseif strcmp(type_mf,'gauss')
                W(j,i)=exp(-((input(j)-params(2))/sqrt(params(1)))^2);
            end
            
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
    k=1
    for i=out_params
        fis = addMF(fis,"output","trimf",[i-0.1, i, i+0.1],'Name',num2str(k));
        k=k+1
    end
    ruleList = ones(number_of_rulse,4)
    for i=1:number_of_rulse
        ruleList(i,1:2)=[i,i]
    end
    fis = addRule(fis,ruleList);


    learning_rate=0.01
    if gradient_decent_flag
        for step=1:20
            output_changes=zeros(number_of_rulse,1);
            param_changes=zeros(number_of_rulse,3);
            for j=1:number_of_data
                %prepare B
                mf_values=zeros(number_of_rulse,1);
                for i=1:number_of_rulse
                    params = fis.Inputs.MembershipFunctions(i).Parameters;
                    val1 = max(0,(input(j)-params(1))/(params(2)-params(1)));
                    val2 = max(0,1-(input(j)-params(2))/(params(3)-params(2)));
                    mf_values(i,1)=min([val1, val2,1]);
                end
                B=sum(mf_values);
                % COmpute parameters changes
                for i=1:number_of_rulse
                    if i==2
                        qewewq=1
                    end
                    params = fis.Inputs.MembershipFunctions(i).Parameters;
                    evaluated_fis=evalfis(fis,input(j));
                    error=output(j)-evaluated_fis;
                    % COmpute output changes
                    output_changes(i,1)=output_changes(i,1)+error*mf_values(i,1)/B;
                    % COmpute other cahnges changes
                    a_sum_helper=0;
                    b_sum_helper=0;
                    c_sum_helper=0;
                    for l=1:number_of_rulse
                        helper_rules = (out_params(l)-evaluated_fis)*mf_values(l,1)/mf_values(i,1);
                        if (params(1)<=input(j)) && (params(2)>=input(j))
                            a_sum_helper=a_sum_helper+(input(j)-params(2))/((params(2)-params(1))^2)*helper_rules;
                            b_sum_helper=b_sum_helper+(params(1)-input(j))/((params(2)-params(1))^2)*helper_rules;
                        elseif (params(2)<input(j)) && (params(3)>=input(j))
                            c_sum_helper=c_sum_helper+(input(j)-params(2))/((params(2)-params(3))^2)*helper_rules;
                            b_sum_helper=b_sum_helper+(params(3)-input(j))/((params(2)-params(3))^2)*helper_rules;
                        end
                    end
                    param_changes(i,1) = param_changes(i,1)+ a_sum_helper*error/B;
                    param_changes(i,2) = param_changes(i,2)+ b_sum_helper*error/B;
                    param_changes(i,3) = param_changes(i,3)+ c_sum_helper*error/B;
                    

    
                end
            end
            out_params =out_params+learning_rate*transpose(output_changes);
            for i=number_of_rulse
                val =out_params(i);
                fis.Outputs.MembershipFunctions(i).Parameters=[val-0.1,val,val+0.1];
            end
            for i=number_of_rulse
                increament=learning_rate*param_changes(i,:);
                fis.Inputs.MembershipFunctions(i).Parameters=fis.Inputs.MembershipFunctions(i).Parameters+increament;
            end
        end
    end
end

%plotfis(fis_tringular)
%plotmf(fis_tringular,'input',1)