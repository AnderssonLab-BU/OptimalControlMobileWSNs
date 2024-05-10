function alpha_list = get_alpha_list(alpha_list,a_i_list,W_list,h)


for i=1:length(alpha_list)
    a = a_i_list(i);
    W = W_list(i);
    alpha_list(i) = (a^2+h^2)^2 + W * a^2+h^2;
end

