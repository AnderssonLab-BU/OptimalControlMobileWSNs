function u_output = IFT_control_output(target_velocity,X_target,s_agent,data_rate,P)
global height W_list u
h=height;

%find non-zero-data-rate
activated_target_index = find(data_rate);
activated_num = length(activated_target_index);


% disp(activated_target_index)

%initialization
a_i_list = zeros(size(X_target));
alpha_list = zeros(size(X_target));
A_list = zeros(size(X_target));

%calculation
a_i_list =get_a_i_list(X_target,s_agent,a_i_list);
alpha_list=get_alpha_list(alpha_list,a_i_list,W_list,h);
A_list=get_A_list(A_list,alpha_list);


%compute Jacobian of x
Jacobian_x_list= zeros(1,activated_num);
for i = 1:activated_num 
    target_index = activated_target_index(i);
%   disp(target_index)
    a_i = a_i_list(target_index);
    A_i = A_list(target_index);
    sum_B = get_sum_B(A_list,alpha_list,a_i_list,W_list,h,target_index);    
    Jacobian_x_list(i) = P(target_index)*(A_i+a_i*sum_B);     
end
Jacobian_x = sum(Jacobian_x_list);

%compute Jacobian of s_i
Jacobian_s_i_list = zeros(1,activated_num);
for i = 1:activated_num 
    target_index = activated_target_index(i);
%   a_i = a_i_list(target_index);
    A_i = A_list(target_index);
    sum_B_P = get_sum_B_P(A_list,alpha_list,a_i_list,W_list,h,target_index,P);    
    Jacobian_s_i_list(i) = P(target_index)*A_i + sum_B_P;           
end

u_s_list=zeros(1,activated_num);
for i = 1:activated_num 
    target_index = activated_target_index(i);
    u_s_list(i) = target_velocity(target_index) * Jacobian_s_i_list(i)/Jacobian_x;
end
u_output = sum(u_s_list);


if u_output >= u(1)
    u_output = u(1);
elseif u_output <= u(2)
    u_output = u(2);
end










