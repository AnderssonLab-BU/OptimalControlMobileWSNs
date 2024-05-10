function sum_B_P = get_sum_B_P(A_list,alpha_list,a_i_list,W_list,h,i,P)

W_i = W_list(i);
a_i = a_i_list(i);
B_j_list = zeros(size(A_list));
for j = 1:length(A_list)
    P_j = P(j);
    a_j = a_i_list(j);
    if i == j
        B_j_list(j) = 0;
    else
        partial_s = 4*a_i^3+a_i*(2*W_i+4*h^2);
        B_j_list(j) = P_j * a_j * partial_s * A_list(i) / alpha_list(j); 
    end
end

sum_B_P = sum(B_j_list);
