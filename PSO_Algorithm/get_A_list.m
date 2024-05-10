function A_list = get_A_list(A_list,alpha_list)

C = 1;
for i=1:length(A_list)
    C = C * alpha_list(i);
end

for i=1:length(A_list)
    A_list(i) = C / alpha_list(i);
end



