clear;clc;close all;
x = ler_tarragona();
%x = ler_census();
%x = ler_eia2();
%x = company();
g = 3;

tic;
[sse, L, P, numC] = GSMS(x,g);
tempo = toc;

fprintf('IL: %f\n',L*100);
fprintf('SSE Mdav: %f\n',sse);
fprintf('Time: %f\n',tempo);