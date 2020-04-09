% teste Algoritmos de microagregação
clear; close all;clc;
%x = company();
%x = ler_tarragona();
x = ler_census();
%x = ler_eia2();
%x = ler_coil();
%x = ler_forest();

g = 3;
sst = fSST(x);

% MD
% tic;
% classes1 = md(x,g);
% tempo1 = toc;

% MDAV
tic;
classes1 = mdav(x,g);
tempo1 = toc;

%MDAV 1
tic;
classes2 = mdav1(x,g);
tempo2 = toc;

% MDAV 2
tic;
classes3 = mdav2(x,g);
tempo3 = toc;

% MDAV 3
tic;
classes6 = mdav3(x,g);
tempo6 = toc;

% MDAVP
tic;
classes4 = mdavp(x,g);
tempo4 = toc;

% MDAVP2
tic;
classes5 = mdavp2(x,g);
tempo5 = toc;

% GSMS
% tic;
% [SSEg, Lg, numC, P] = GSMS_T2(x,g,1);
% tempoG = toc;
% fprintf('Tempo GSMS: %f\n\n',tempoG);
% 
tic;
classes8 = cbfs(x,g);
tempo8 = toc;

%% Resultado Md
% sse = fSSE(x,classes1,g);
% loss = sse/sst;
% fprintf('IL Md: %f\n',loss*100);
% fprintf('SSE: %f\n',sse);
% fprintf('Time: %f\n\n',tempo1);
%% Resultado Mdav
sse = fSSE(x,classes1,g);
loss = sse/sst;
fprintf('IL Mdav: %f\n',loss*100);
fprintf('SSE: %f\n',sse);
fprintf('Time: %f\n\n',tempo1);

% Resultado Mdav 1
sse1 = fSSE(x,classes2,g);
loss1 = sse1/sst;
fprintf('IL Mdav1: %f\n',loss1*100);
fprintf('SSE: %f\n',sse1);
fprintf('Time: %f\n\n',tempo2);

% Resultado Mdav 2
sse2 = fSSE(x,classes3,g);
loss2 = sse2/sst;
fprintf('IL Mdav2: %f\n',loss2*100);
fprintf('SSE: %f\n',sse2);
fprintf('Time: %f\n\n',tempo3);

% Resultado Mdav 3
% sse3 = fSSE(x,classes5,g);
% loss3 = sse3/sst;
% fprintf('IL Mdav3: %f\n',loss3*100);
% fprintf('SSE: %f\n',sse3);
% fprintf('Time: %f\n\n',tempo5);

% Resultado Mdavp
sse4 = fSSE(x,classes4,g);
loss4 = sse4/sst;
fprintf('IL Mdavp: %f\n',loss4*100);
fprintf('SSE: %f\n',sse4);
fprintf('Time: %f\n\n',tempo4);

% Resultado Mdavp2 
sse5 = fSSE(x,classes5,g);
loss5 = sse5/sst;
fprintf('IL Mdavp2: %f\n',loss5*100);
fprintf('SSE: %f\n',sse5);
fprintf('Time: %f\n\n',tempo5);

% Resultado GSMS
% lossgsms = SSEg/sst;
% fprintf('IL GSMS: %f\n',lossgsms*100);
% fprintf('SSE: %f\n',SSEg);
% fprintf('Time: %f\n\n',tempoG);

% Resultado CBFS
sse8 = fSSE(x,classes8,g);
loss8 = sse8/sst;
fprintf('IL CBFS: %f\n',loss8*100);
fprintf('SSE: %f\n',sse8);
fprintf('Time: %f\n\n',tempo8);

% s = [classes; classes1; classes3; classes2; classes4; classes5];
%s = [classes;classes1;classes2];
%s = [classes3;classes4;classes5];
%pos = solucao_intersec(s);
%fprintf('Cluster repetido: %d\n',pos);

%% Matriz de incidência
m1 = matriz_incidencia(classes1);
m2 = matriz_incidencia(classes2);
m3 = matriz_incidencia(classes3);
m4 = matriz_incidencia(classes4);
m5 = matriz_incidencia(classes5);

t = m1 + m2 + m3 + m4 + m5;

%% Porcentagem de cluster repetidos
por = porcentagem(t);
fprintf('Porcentagem de cluster repetidos: %0.2f%%\n',por);

%% Plota resultados
% best = [1 1 1 2 2 3 3 3 2 1 3];
% ssebest = fSSE(x,best,g);
% lossbest = ssebest/sst;

% figure;
% maxClass = ver_classes(x);
% colors = rand(maxClass,3);
% plota(x,classes5,colors);