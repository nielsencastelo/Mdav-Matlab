% Teste do H-means com Mdav
clear;close all;clc;

%x = company();
x = ler_census();
g = 3;
sst1 = fSST(x);

%classes = ones(1,size(x,1));
tic;
%classes = hmeans(x,10);
classes = kmeans(x,100);
%classes = mdav3(x,g);
classes = mdav1(x,g,classes);
tempo1 = toc;

sse1 = fSSE(x,classes,g);
loss1 = sse1/sst1;
fprintf('IL Mdav1: %f\n',loss1*100);
fprintf('SSE Mdav1: %f\n',sse1);
fprintf('Time1: %f\n\n',tempo1);