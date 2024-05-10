function particle_swarm = Generating_particle_swarm(Policy_para,Policy_Space,event_num,particle_num)

move_step_Theta = Policy_para(1,:);
move_step_W = Policy_para(2,:);
move_step_P = Policy_para(3,:);


particle_swarm=repmat(struct('index',[],'policy_param',[],'velocity',[],'policy_param_best',[],'J_best',[]),1,particle_num);

for i =1:particle_num
    Theta = Policy_Space(1) + move_step_Theta.* (0.5 - rand(event_num,1));
    w = Policy_Space(2) + move_step_W.* (0.5 - rand(event_num,1));
    P= Policy_Space(3) + move_step_P.* (0.5 - rand(event_num,1));

    Theta_v = Policy_Space(1) + move_step_Theta.* (0.5 - rand(event_num,1));
    w_v = Policy_Space(2) + move_step_W.* (0.5 - rand(event_num,1));
    P_v= Policy_Space(3) + move_step_P.* (0.5 - rand(event_num,1));
    
    
    add_particle = struct('index',i,'policy_param',[Theta';w';P'],'velocity',0.2*[Theta_v';w_v';P_v'],'policy_param_best',[Theta';w';P'],'J_best',1000);
    particle_swarm(i)=add_particle;
end