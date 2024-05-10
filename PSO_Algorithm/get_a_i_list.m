function a_i_list = get_a_i_list(X_target,s_agent,a_i_list)

for i=1:length(a_i_list)
a_i_list(i) = s_agent - X_target(i);
end