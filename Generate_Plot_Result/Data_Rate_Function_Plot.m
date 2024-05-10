%Start test

X_list=[-10:0.005:10];
Y_list=Rate(X_list);

color_bar5=[0.6,0.3,0.8]*0.93;
plot(X_list,Y_list,'-','color',color_bar5,'LineWidth',1);

%% Functions
function Y_list = Rate(X_list)
n_size=size(X_list,2);
Y_list=zeros(size(X_list));

for i=1:n_size
    Y_list(i)=F(X_list(i));
end

end

function Y = F(x)
B=1;
height=1;
K=1;

distance=abs(x);
Y =B*log2(1 + K/(distance^2+ height^2));
disp(Y);
end

