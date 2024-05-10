function Singular_Arc_Distance = Generating_Singular_Arc(target_velocity,X_target,s_agent,data_rate,P)
global height W_list
h=height;

%find non-zero-data-rate
activated_target_index = find(data_rate);
activated_num = length(activated_target_index);
% disp(activated_target_index)

if activated_num >= 1
    %initialization
    a_i_list = zeros(size(X_target));
    alpha_list = zeros(size(X_target));
    %calculation
    a_i_list =get_a_i_list(X_target,s_agent,a_i_list);
    alpha_list=get_alpha_list(alpha_list,a_i_list,W_list,h);
    Singular_Arc_Distance_list= zeros(1,activated_num);
    for i = 1:activated_num 
        target_index = activated_target_index(i);
        a_i = a_i_list(target_index);
        Singular_Arc_Distance_list(i) = P(target_index)*a_i/alpha_list(target_index);   
    end
        Singular_Arc_Distance = abs(sum(Singular_Arc_Distance_list));
else
    Singular_Arc_Distance = 1000;
end



