%Code for PSO method for Data Harvesting Problem with 3 sensor nodes

addpath(genpath('IFT_Control_Policy'))
addpath(genpath('PSO_Algorithm'))
addpath(genpath('Generate_Plot_Result'))

%(1)Setting of Environment:
%X_target - set of target position
%S - start and final position of agent
%r - set of data volume to be harvested
%R - set of data collected from targets
%u - set of speed boundary
%Theta - set of time for maximum speed moving
%W - set of time for convex combination speed moving
%P - set of parameters related to costate value
%J - the fincal objective function value


tic

global X_sensing_radius X_target_velocity period_list r  u B_list height W_list data_rate_bound Activate_num 

X_target = [3.5 5 6];
S=[0 10 0];
u=[1.0 -1.0 0];
Env_info= [X_target;S;u];
n_target=length(X_target);

%Parameters of sensor nodes
B_list = [2 2 1];
height = 1;
W_list = [3 2 2];
X_sensing_radius = [3 3 4];
data_rate_bound = Generating_data_rate_bound(X_sensing_radius,n_target);
X_target_velocity = [0.5 0.3 -0.05];
period_list = [2 5 0];
r = [20 20 10];
R=[0 0 0];
Target_info = [X_sensing_radius;X_target_velocity;period_list;r;R];


%Policy-initionalization
Event_num = 3;
Activate_num = 1;
Theta= repelem(1.0,Event_num)';
w=repelem(1.0,Event_num)';
P=repelem(1.0,Event_num)';
Parameters=[Theta';w';P'];


particle_swarm_best_list=[];
particle_swarm_best = [];
J_best_list=[];
J_best = 1000;
Para_swarm_list=[];


%Parameters of Random Policty
particle_num = 50;
Policy_Space=[2 5 0];
move_range_Theta = 6;
move_range_W = 10;
move_range_P = 10;
Policy_para = [move_range_Theta;move_range_W;move_range_P];
iteration_time = 1;


%(2)Particle Swarm Optimization
particle_swarm = Generating_particle_swarm(Policy_para,Policy_Space,Event_num,particle_num);

while iteration_time <= 30
fprintf('\nStarting %d iteration. The optimization function J = %.3f \n', iteration_time,J_best);
Para_swarm_list = [Para_swarm_list; particle_swarm];


%(3)Computation of best_position
[particle_swarm,particle_swarm_best,J_best] = Generating_best_position(Env_info,Target_info,particle_swarm,Parameters,J_best,particle_swarm_best);


%(4)Update swarm position
particle_swarm = Updata_Swarm_Position(particle_swarm,particle_swarm_best,iteration_time);


%(5)Updating J_record
J_best_list=[J_best_list J_best];
particle_swarm_best_list = [particle_swarm_best_list particle_swarm_best];
fprintf('The next best particle');
disp(particle_swarm_best)
iteration_time=iteration_time+1;
end 


%(6)Output of Plots
Parameters(1:3,:) = particle_swarm_best.policy_param;
[T_list, R_list, Phi_list, S_list] = Data_collecting(Env_info,Target_info,Parameters(1,:),Parameters(2,:),Parameters(3,:));



%(7)Plots of Targets
Result_plotout_Mobile_3nodes(T_list, R_list, Phi_list, S_list, n_target);


color_bar5=[0.6,0.3,0.8]*0.93;
figure(4)
plot(1:iteration_time-1,J_best_list,'-','color',color_bar5);
xlabel('Iterations')
ylabel('J Value')
title('J Value Plot')
fprintf('The final plots are printed.\n');


toc



