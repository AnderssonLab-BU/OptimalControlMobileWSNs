function Result_plotout_Mobile(T_list, R_list, Phi_list, S_list,n_target)
color_bar1=[0.9,0.5,0.9]*0.9;
color_bar2=[0.9,0.5,0.5]*0.9;
color_bar3=[0.5,0.8,0.9]*0.9;
color_bar4=[0.6,0.6,0.95]*0.8;


transp = 0.3;
global X_sensing_radius

if n_target <=3
figure(1)
plot(T_list,R_list(1,:),'-','color',color_bar1,'LineWidth',2);
hold on
plot(T_list,R_list(2,:),'-','color',color_bar2,'LineWidth',2);
hold on
plot(T_list,R_list(3,:),'-','color',color_bar3,'LineWidth',2);
legend('Target1','Target2','Target3')
xlabel('Time')
ylabel('Data Volume')
xlim([0,T_list(end)]);
ylim([0,8]); 
title('Data Collected from Targets')
fig1 = figure(1);
% saveas(fig1,'C:\Users\12647\Desktop\fig1_R_iso.eps','epsc')

%Plot of Phi the data rate
figure(2)
plot(T_list,Phi_list(1,:),'-','color',color_bar1,'LineWidth',2);
hold on
plot(T_list,Phi_list(2,:),'-','color',color_bar2,'LineWidth',2);
hold on
plot(T_list,Phi_list(3,:),'-','color',color_bar3,'LineWidth',2);
legend('Target1','Target2','Target3')
xlabel('Time')
ylabel('Data Transmitting Rate')
xlim([0,T_list(end)]);
ylim([0,5]); 
title('Data Transmitting Rate of Targets')
fig2 = figure(2);
% saveas(fig2,'C:\Users\12647\Desktop\fig2_Phi_iso.eps','epsc')

%Plot of Phi the data rate
figure(3)
radius = X_sensing_radius;
%Area of sensing range
x2 = [T_list, fliplr(T_list)];
inBetween = [S_list(2,:) - radius(1), fliplr(S_list(2,:) + radius(1))];
fill(x2, inBetween, color_bar1,'FaceAlpha',transp);
hold on
x2 = [T_list, fliplr(T_list)];
inBetween = [S_list(3,:) - radius(2), fliplr(S_list(3,:) + radius(2))];
fill(x2, inBetween, color_bar2,'FaceAlpha',transp);
hold on
x2 = [T_list, fliplr(T_list)];
inBetween = [S_list(4,:) - radius(3), fliplr(S_list(4,:) + radius(3))];
fill(x2, inBetween, color_bar3,'FaceAlpha',transp);
hold on

%Plot
plot(T_list,S_list(1,:),'-','color',color_bar4,'LineWidth',2);
hold on
plot(T_list,S_list(2,:),'-','color',color_bar1,'LineWidth',2);
hold on
plot(T_list,S_list(3,:),'-','color',color_bar2,'LineWidth',2);
hold on
plot(T_list,S_list(4,:),'-','color',color_bar3,'LineWidth',2);
hold on
plot(T_list,S_list(1,:),'-','color',color_bar4,'LineWidth',2);
legend('Target1','Target2','Target3','Agent')
%label
xlabel('Time')
ylabel('Agent Postition')
y_max=max(S_list(1,:));
xlim([0,T_list(end)]);
ylim([0,y_max+1.6]);   
title('Agent Postition Plot')
fig3 = figure(3);
% saveas(fig3,'C:\Users\12647\Desktop\fig3_St_iso.eps','epsc')

end


