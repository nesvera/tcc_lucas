
%% inicializa��o

clear all
close all
clc

%% par�metros do sistema

g = 9.8065; %acelera��o da gravidade - m/s^2

% Campo magnetico terrestre em Santa Maria (CT). Calculado pelo IGRF-12.
% As coordenadas estao no sistema NED. A unidade eh Testa
mgeo=[17223.7  -4581.6 -13698.2 ]'*1e-9; % Tesla

m = 1.03; % massa - kg

ct = 1.4341*10^(-5); %const. de empuxo - N/(rad/s)^2
cq = 2.4086*10^(-7) ; %const de torque - N/(rad/s)^2

Jxx= 0.01683;
Jyy= 0.01683;
Jzz= 0.02834;
Jm=3.7882e-06;
J=[Jxx,Jyy,Jzz,Jm];

d= 0.26; %dist. h�lice do cg - m

kt = 0.024; %const. de torque eletromec�nico
ke = kt; %const. for�a eletromotriz

R = 0.2; %resist�ncia da armadura
Ja = 5e-5; % momento de in�rcia do motor, eixo e h�lice
max_w = 733.03; %m�xima rota��o dos motores (7000 rpm)

w_hover = sqrt(m*g/(4*ct));

% Accelerometers error model

accel_noise = 0; %1=on, 0=off

% varAccx=5e-2;  % (mps^2)^2
% varAccy=5e-2;  % (mps^2)^2
% varAccz=5e-2;  % (mps^2)^2 

Tsr=1e-2;   % Tempo de amostragem dos ruidos: 500Hz
varAccx=5e-4;  % (mps^2)^2
varAccy=5e-4;  % (mps^2)^2
varAccz=5e-4;  % (mps^2)^2 

baccx=1e-1; % mps^2   
baccy=1e-1; % mps^2   
baccz=1e-1; % mps^2

% Gyros error model

gyro_noise = 0; %1=on, 0=off

varGyrp=1e-5;  % radps^2
varGyrq=1e-5;  % radps^2
varGyrr=1e-5;  % radps^2 

bgyrp=1e-3; % radps   
bgyrq=1e-3; % radps   
bgyrr=1e-3; % radps

% Barometer error model

baro_noise = 0; %1=on, 0=off

varbar= 1e-1;%   % m^2

Ts_bar=0.1;  % Barometer sampling time (s)

% Magnetometers error model

mag_noise = 0; %1=on, 0=off


varMagx=1e-14;  % (Tesla)^2
varMagy=1e-14;  % (Testa)^2
varMagz=1e-14;  % (Testa)^2 

bmagx=1e-6; % Tesla   
bmagy=-1e-6; % Tesla   
bmagz=1e-6; % Tesla

% GPS error Model
fGPS=5; % Hz
TsGPS=1/fGPS;

Tnoise_gps=TsGPS;  % Time sample of the GPS noise

var_disp_gps=0.5e-1;
var_vel_gps=2e-3;

gps_noise_on = 0;

% Frequencia de corte no filtro de velocidade do GPS, usado antes da
% derivada
w_f_gps=2*pi*(2*fGPS);  % Uma oitava acima da frequencia de amostragem do GPS

% Inertial acceleration
t_d=50e-3;    % Time constant of the approximate derivative

% Correct horizontal acceleration
correct_acc=1;  % 1: correction, 0: no correction

% Fiter TRIAD computation
w_f_triad=2*pi*(10);   % Cut-off frequency of 10 Hz

%% condi��es iniciais

x0=0;y0=0;z0=0;
vx0=0;vy0=0;vz0=0;
phi0=0;theta0=0;psi0=0;
p0=0;q0=0;r0=0;
w1_0=w_hover; w2_0=w_hover; w3_0=w_hover; w4_0=w_hover;

tempofinal=1;
% DEFINE O TEMPO DE DISCRETIZACAO
Td=0.02;    % [segundos]

%% par�metros dos controles PD

controle=1; % 0 = sliding mode, 1 = pd

%altura
Z_P=-0.238672;
Z_D=-0.682000;

%roll
Roll_P= 0.019948;
Roll_D=0.019;

%pitch
Pitch_P= 0.019948;
Pitch_D= 0.019;

%yaw
Yaw_P=0.039055;
Yaw_D=0.037200;

%posi��o

pos_P = -0.005948; 
pos_D = -0.033991;

%% par�metros do controle sliding mode

%altura
lambda1 = 1; %tau=1
k1 = 2.5; %t_alc=3, s(0)=7.5

%roll
lambda2=5; %tau=0.2
k2=6.2360; %t_alc=1, s(0)=3.118

%pitch
lambda3=5; %tau=0.2
k3=6.2360; %t_alc=1, s(0)=3.118

%yaw
lambda4=1/2; %tau=2
k4=0.4927 ; %t_alc=1, s(0)=0.4927

%posi��o
lambda5=1/4; %tau=4
k5=1.6; %t_alc=3, s(0)=4.8

lambda6=1/4; %tau=4
k6=1.6; %t_alc=3, s(0)=4.8

%limite fun��o satura��o, se limite=0 a fun��o sat() � igual � sign()

limit=[0.5 0.5 0.5 0.5];
limit_pos=[0.5 0.5];


%% contador para condicao inicial do XPlane

cont=0;

%% rodar simula��o

%par�metros que v�o na din�mica do quadric�ptero (incluir varia��es
%param�tricas neles)
J_real = J;
ct_real = ct;
cq_real = cq;
m_real = m;



%compara��o entre PD e sliding mode

% controle=1;
% sim('modelo_quad12');
controle=0;
%sim('modelo_quad13_ver76.mdl');
%sim('SITL');

%compara��o entre PD e sliding mode com ru�dos nos sensores

% accel_noise = 1;
% gyro_noise = 1;
% baro_noise = 1;
% 
% controle=1;
% sim('modelo_quad12');
% controle=0;
% sim('modelo_quad12');

%controle sliding mode com varia��es param�tricas


% controle=0;
% for var=0:3
%    J_real = J*(1+0.1*var); 
%    m_real = m*(1+0.1*var);
%    
%     sim('modelo_quad12');
% end

%% plot

yout=squeeze(yout)';
plot_resultados(yout,tout);

%% animation
% QuadAnim