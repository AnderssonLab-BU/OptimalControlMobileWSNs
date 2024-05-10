function particle_swarm = Updata_Swarm_Position(particle_swarm,particle_swarm_best,iter_num)


gamma = 0.9995^iter_num;

val_1 = 3 * rand(1,1);
val_2 = 3 * rand(1,1);
r_0 = 0.7;
r_1 = 0.5;
r_2 = 0.5;
% Phi_global = 0.5;
% Phi_indiv = 0.5;
Phi_global = 0.5;
Phi_indiv = 0.5;

num = length(particle_swarm);

for i=1:num
    velocity_global_best = particle_swarm_best.policy_param - particle_swarm(i).policy_param;
    velocity_indiv_best = particle_swarm(i).policy_param_best - particle_swarm(i).policy_param;

    
    particle_swarm(i).velocity = r_0 * particle_swarm(i).velocity  +  0.9*gamma * (r_1 .* val_1 * Phi_global * velocity_global_best + r_2 .* val_2 * Phi_indiv * velocity_indiv_best);
    particle_swarm(i).policy_param = particle_swarm(i).policy_param + particle_swarm(i).velocity;    

end

disp(particle_swarm(end).velocity)