function sum_B = get_sum_B(A_list,alpha_list,a_i_list,W_list,h,i)

B_j_list = zeros(size(A_list));
for j = 1:length(A_list)
    if i == j
        B_j_list(j) = 0;
    else
        W_j = W_list(j);
        a_j = a_i_list(j);
        partial_x = 4*a_j^3+a_j*(2*W_j+4*h^2);
        B_j_list(j) = partial_x * A_list(i) / alpha_list(j); 
    end
end

sum_B = sum(B_j_list);