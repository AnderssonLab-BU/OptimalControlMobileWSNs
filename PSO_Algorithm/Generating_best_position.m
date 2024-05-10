function [particle_swarm,particle_swarm_best,J_best] = Generating_best_position(Env_info,Target_info,particle_swarm,Parameters,J_best,particle_swarm_best)
num = length(particle_swarm);
update_count =0;
for i = 1:num
    Parameters(1:3,:)= particle_swarm(i).policy_param;
    J = J_Computation_Mobile(Env_info,Target_info,Parameters(1,:),Parameters(2,:),Parameters(3,:));
    
    if J < particle_swarm(i).J_best
        update_count =update_count+1;
        particle_swarm(i).J_best = J;
        particle_swarm(i).policy_param_best = particle_swarm(i).policy_param;
    end
    
    if J < J_best
        J_best = J;
        particle_swarm_best = particle_swarm(i);
    end

end

disp('particle updated');
disp(update_count);

