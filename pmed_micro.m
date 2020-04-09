clc;close all; clear;

bairros = [1 3 5 3 7 2 8; ...
           7 5 3 8 2 6 5];
       
tb = length(bairros);

% Visualiza a distância dos bairros
hold on;
for i = 1 : tb
    plot(bairros(1,i), bairros(2,i),'-mo','LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',8);
end
g = 3;
x = bairros';
classes = mdav(x,g);
centros = centroideclass(x,classes);

% Determinando as distância entre os centroides
high = size(x,1);
[k,~] = size(centros);
dist = zeros(high,k);
for var = 1:high
    for c = 1:k
        soma = 0;
        for s = 1:size(x,2)
            soma = soma + (x(var,s) - centros(c,s)).^2;
        end
        dist(var,c) = sqrt(soma);
    end
end

% Quem são os mais proximos de cada centro
indices = zeros(c,1);
for var = 1: c
    [~,indices(var)] = min(dist(:,var));
end
pontos = x(indices,:);
% Mostra resultados
figure;
maxClass = ver_classes(bairros');
colors = rand(maxClass,3);
plota(bairros',classes,colors);
plotaCentroide(centros,'r'); % Plota o centroide
plotaCentroide(pontos,'b');  % Plota o mais próximo do centroide