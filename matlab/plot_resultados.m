function [] = plot_resultados(yout,tout)

%close all; 
clc;


A = yout;
t = tout;
% t = T;

X = A(:,1);
Y = A(:,2);
Z = A(:,3);

Vx = A(:,4); 
Vy = A(:,5);
Vz = A(:,6);

phi   = A(:,7); 
theta = A(:,8);
psi   = A(:,9);

P = A(:,10); 
Q = A(:,11);
R = A(:,12);


% w1 = A(:,13);
% w2 = A(:,14);
% w3 = A(:,15);
% w4 = A(:,16);

%w1 = A(:,16);
%w2 = A(:,17);
%w3 = A(:,18);
%w4 = A(:,19);

% Plots
figure

subplot(4,3,1)
plot(t,X,'b','linewidth',3)
xlabel('Tempo (s)')
ylabel('Posição (m)')
xlim([min(t) max(t)])
title('X')
axis tight
grid on

subplot(4,3,2)
plot(t,Y,'r','linewidth',3)
xlabel('Tempo (s)')
ylabel('Posição (m)')
xlim([min(t) max(t)])
title('Y')
axis tight
grid on

subplot(4,3,3)
plot(t,-Z,'g','linewidth',3)
xlabel('Tempo (s)')
ylabel('Posição (m)')
xlim([min(t) max(t)])
title('Altura (-Z)')
axis tight
grid on

subplot(4,3,4)
plot(t,Vx,'b','linewidth',3)
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
xlim([min(t) max(t)])
title('Vx')
axis tight
grid on

subplot(4,3,5)
plot(t,Vy,'r','linewidth',3)
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
xlim([min(t) max(t)])
title('Vy')
axis tight
grid on

subplot(4,3,6)
plot(t,-Vz,'g','linewidth',3)
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
xlim([min(t) max(t)])
title('-Vz')
axis tight
grid on

subplot(4,3,7)
plot(t,phi*180/pi,'b','linewidth',3)  %converter de rad para º
xlabel('Tempo (s)')
ylabel('Ângulo (º)')
xlim([min(t) max(t)])
title('\Phi')
axis tight
grid on
 
subplot(4,3,8)
plot(t,theta*180/pi,'r','linewidth',3) %converter de rad para º
xlabel('Tempo (s)')
ylabel('Ângulo (º)')
xlim([min(t) max(t)])
title('\Theta')
axis tight
grid on

subplot(4,3,9)
plot(t,psi*180/pi,'g','linewidth',3) %converter de rad para º
xlabel('Tempo (s)')
ylabel('Ângulo (º)')
xlim([min(t) max(t)])
title('\Psi')
axis tight
grid on


subplot(4,3,10)
plot(t,P*180/pi,'b','linewidth',3) %converter de rad/s para º/s
xlabel('Tempo (s)')
ylabel('Velocidade angular (º/s)')
xlim([min(t) max(t)])
title('P')
axis tight
grid on

subplot(4,3,11)
plot(t,Q*180/pi,'r','linewidth',3) %converter de rad/s para º/s
xlabel('Tempo (s)')
ylabel('Velocidade angular (º/s)')
xlim([min(t) max(t)])
title('Q')
axis tight
grid on

subplot(4,3,12)
plot(t,R*180/pi,'g','linewidth',3) %converter de rad/s para º/s
xlabel('Tempo (s)')
ylabel('Velocidade angular (º/s)')
xlim([min(t) max(t)])
title('R')
axis tight
grid on

