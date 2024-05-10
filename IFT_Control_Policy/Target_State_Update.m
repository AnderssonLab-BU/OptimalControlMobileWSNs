function [X_target,target_velocity]=Target_State_Update(X_target,target_velocity,time_step,target_velocity_intial,T,period_list)

X_target = X_target + target_velocity * time_step;
n_target = length(target_velocity_intial);


for i=1:n_target

    if period_list(i) > 0
        target_velocity(i) = target_velocity_intial(i)*sin(pi*T/period_list(i));
    elseif period_list == 0
        target_velocity(i) = target_velocity_intial(i);
    end

end
