% Microagregação com SOM


clear;clc;close all;
%x = ler_tarragona();
%x = ler_census();
%x = ler_eia2();
x = company();
g = 3;

% Create a Self-Organizing Map
dimension1 = 11;
dimension2 = 2;
net = selforgmap([dimension1 dimension2]);

% Train the Network
[net,tr] = train(net,x);

% View the Network
view(net)
% Plots
% Uncomment these lines to enable various plots.
%figure, plotsomtop(net)
%figure, plotsomnc(net)
%figure, plotsomnd(net)
%figure, plotsomplanes(net)
%figure, plotsomhits(net,inputs)
%figure, plotsompos(net,inputs)
