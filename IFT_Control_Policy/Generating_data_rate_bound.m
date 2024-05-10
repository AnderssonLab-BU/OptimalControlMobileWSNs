function data_rate_bound = Generating_data_rate_bound(X_sensing_radius,n_target)

global X_sensing_radius B_list height W_list data_rate_bound
distance_sensing = X_sensing_radius;

%Computation of data_rate
for i=1:n_target
    data_rate_bound(i) = B_list(i)*log2(1+W_list(i)/(distance_sensing(i)^2+ height^2));
end