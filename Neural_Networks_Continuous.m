clear
clc
close all

%% Parameters

%% GAINS
k = [20 0; 0 5];
kn =[20 0; 0 5];
alpha = 3;
gamma1 = 500;
gamma2 = 1000;

v_initial = zeros(7,5);
w_initial = zeros(6,2);


%% Run Simulation
[t,~,states,u,qd,f_hat,f,w_hat,v_hat] = sim('Model_Composite_2Link_NN_Continuous');

%% Analysis/Plot

states = [states(:,3:4),states(:,1:2)]; % reorder states to [pos1, pos2, vel1, vel2]
error = qd-states;
rms = sqrt(mean(error.^2))*180/pi;

figure;
subplot(2,2,1);
plot(t,states(:,1)*180/pi,'r',t,states(:,2)*180/pi,'b',t,qd(:,1)*180/pi,'r--',t,qd(:,2)*180/pi,'b--','LineWidth',1.2);
xlabel('Time');
ylabel('States (in degrees)');
title('Desired Vs Actual Trajectories');
xlim([0 t(end)]);
grid on;
ax = gca;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.FontSize = 16;
ax.LineWidth = 1.4;
leg1 = legend('$q_1$','$q_2$','$q_{d1}$','$q_{d2}$');
set(leg1,'Interpreter','latex');
hold on;

% figure;
subplot(2,2,2);
plot(t,error(:,1)*180/pi,'r',t,error(:,2)*180/pi,'b','LineWidth',1.2);
xlabel('Time');
ylabel('Tracking Errors(in degrees)');
title('Tracking Errors Vs Time');
xlim([0 t(end)]);
grid on;
ax = gca;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.FontSize = 16;
ax.LineWidth = 1.4;
leg3 = legend('$e_1$','$e_2$');
set(leg3,'Interpreter','latex');
hold on;

% figure;
subplot(2,2,3);
plot(t,f_hat(:,1),'r',t,f_hat(:,2),'b','LineWidth',1.2);
xlabel('Time');
ylabel('Adaptive Estimates');
title('Adaptive Estimates Vs Time');
xlim([0 t(end)]);
grid on;
ax = gca;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.FontSize = 16;
ax.LineWidth = 1.4;
leg2 = legend('$\widehat{f}_{1}$','$\widehat{f}_{2}$');
set(leg2,'Interpreter','latex');
hold on;

% figure;
subplot(2,2,4);
plot(t,f(:,1)-f_hat(:,1),'r',t,f(:,2)-f_hat(:,2),'b','LineWidth',1.2);
xlabel('Time');
ylabel('Actual function value - NN Approximation');
title('Function Approximation Error');
xlim([0 t(end)]);
grid on;
ax = gca;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.FontSize = 16;
ax.LineWidth = 1.4;
leg2 = legend('$f_{1} - \widehat{f}_{1}$' , '$ f_{2} - \widehat{f}_{2}$');
set(leg2,'Interpreter','latex');
hold on;

figure;
plot(t,u(:,1),'r',t,u(:,2),'b','LineWidth',1.2);
xlabel('Time');
ylabel('Controls');
title('Controls Vs Time');
xlim([0 t(end)]);
grid on;
ax = gca;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.FontSize = 16;
ax.LineWidth = 1.4;
leg5 = legend('$\tau_1$','$\tau_2$');
set(leg5,'Interpreter','latex');
hold on;

u1max=max(abs(u(:,1)))
u2max=max(abs(u(:,2)))