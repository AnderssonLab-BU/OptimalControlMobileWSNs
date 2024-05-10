function [J,Final_Phi] = J_Computation_Mobile(Env_info,Target_info,Theta,W,P)
%Initilization of Parameters
%time_step
%T - time spent
%s_agent - position of agent
%u_speed - speed of agent
%i - parameter of Theta and W

global Activate_num


X_target = Env_info(1,:);
S=Env_info(2,:);
u=Env_info(3,:);
n_target=length(X_target);

X_target_velocity = Target_info(2,:);
period_list=Target_info(3,:);
r=Target_info(4,:);
R=Target_info(5,:);


time_step=0.001;
Tolerance=0.0002;
T=0;
s_agent=S(1);
% n_visiting_time=length(W);
n_visiting_time = Activate_num;

target_velocity_intial = X_target_velocity;
target_velocity = X_target_velocity;
[X_target,target_velocity]=Target_State_Update(X_target,target_velocity,time_step,target_velocity_intial,T,period_list);


for i = 1:n_visiting_time
    % disp(i)
    T_Tracking = 0;
    Traveling_time = 0;
    

    %Moving to the time point
    data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
    Singular_Arc_Distance = Generating_Singular_Arc(target_velocity,X_target,s_agent,data_rate,P);
    while Singular_Arc_Distance > Tolerance
        [X_target,target_velocity] = Target_State_Update(X_target,target_velocity,time_step,target_velocity_intial,T,period_list);
        Singular_Arc_Distance = Generating_Singular_Arc(target_velocity,X_target,s_agent,data_rate,P);
        data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
        R = R + time_step*data_rate;
        u_speed = u(1) * sign(Theta(i));
        s_agent =s_agent + time_step * u_speed;
        T = T + time_step;
        if s_agent > 10
            break
        end
        if s_agent < 0
            break
        end
    end    
    

    %Start convex velocity
    while T_Tracking < W(i)
        [X_target,target_velocity] = Target_State_Update(X_target,target_velocity,time_step,target_velocity_intial,T,period_list);
        data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
        R = R + time_step*data_rate;
        u_speed = IFT_control_output(target_velocity,X_target,s_agent,data_rate,P); 
        s_agent =s_agent + time_step*u_speed;
        T = T + time_step;
        T_Tracking = T_Tracking + time_step; 
    end
    

    %Keep Moving
    while Traveling_time <= 0.001
        [X_target,target_velocity] = Target_State_Update(X_target,target_velocity,time_step,target_velocity_intial,T,period_list);
        data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
        R = R + time_step*data_rate;
        u_speed = u(1);
        s_agent =s_agent + time_step * u_speed;
        T = T + time_step;
        Traveling_time = Traveling_time + time_step;
    end   
end


%Collecting while moving
while abs(s_agent-S(2)) >= 0.001
    [X_target,target_velocity]=Target_State_Update(X_target,target_velocity,time_step,target_velocity_intial,T,period_list);
    data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
    R = R + time_step*data_rate;
    u_speed = u(1);
    %Iteration of agent position and time
    direction=-(s_agent-S(2))/abs(s_agent-S(2));
    s_agent =s_agent + time_step*u_speed*direction;
    T = T + time_step;
end


%When reach to the end point
while R_Data_Satisfied(R,r) == 0
    [X_target,target_velocity]=Target_State_Update(X_target,target_velocity,time_step,target_velocity_intial,T,period_list);
    u_speed=0;
    data_rate = repelem(0.1,n_target);
    R = R + time_step*data_rate;
    s_agent =s_agent + time_step*u_speed;
    T = T + time_step;
end


%Final Output
Final_Phi = data_rate;
J = T;


