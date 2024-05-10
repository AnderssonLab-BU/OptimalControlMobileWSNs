function data_rate = Phi_transmitting_speed(agent,X_target,r,R,n_target)
%Parameter setting
%Each meaning
global X_sensing_radius B_list height W_list data_rate_bound

data_rate=zeros(1,n_target);
distance=zeros(1,n_target);
distance_sensing = X_sensing_radius;

%Computation of data_rate
for i=1:n_target
    distance(i)=abs(agent-X_target(i));

    if distance_sensing(i) > distance(i)
        data_rate(i) = B_list(i)*log2(1+W_list(i)/(distance(i)^2+ height^2)) - data_rate_bound(i);
    else
        data_rate(i) = 0;
    end   
    
    if R(i)>= r(i)
        data_rate(i) = 0;
    end

end






