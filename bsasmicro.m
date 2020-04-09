% BSAS Microaggregation

clc;clear;close all;

%x = company();
x = ler_tarragona();
%x = ler_eia2();
sst = fSST(x);

x = x';
%g = 3;
q = 3;     % máximo número de clusters
theta = 1; % threshold

[l,N] = size(x);
order = 1:1:N;

% Determinação da faze do Cluster
n_clust = 1;  % n. de clusters

classes = zeros(1,N);
classes(order(1)) = n_clust;
repre = x(:,order(1));
tic;
for i = 2 : N
    [m1,m2] = size(repre);
    % Determinando o representante mais próximo do cluster
    [s1,s2] = min(sqrt(sum((repre - x(:,order(i))*ones(1,m2)).^2)));
    
    % Teste de inviabilidade
    %maxClass = max(classes(1:order(i)));          % ver a qtd de classes
    %qtd_cla = qtd_classes(classes(1:order(i)),maxClass); % cada linha é o nº de objetos na classe
    %[tam,cla] = min(qtd_cla); % Vejo se tem classe que tem não atende ao
                               % critério do g
    
    if(s1 > theta) && (n_clust < q)  %&& (tam>=g)
        n_clust = n_clust + 1;
        classes(order(i)) = n_clust;
        repre = [repre x(:,order(i))];
    else
        %s2 = n_clust;
        classes(order(i))= s2;
        repre(:,s2) = ((sum(classes == s2)-1)*repre(:,s2) + x(:,order(i)))/sum(classes == s2);
    end
end
tempo1 = toc;
%classes = invibialidade2(classes,3);

% maxClass = ver_classes(x);
% colors = rand(maxClass,3);
% plota(x',classes,colors);
% 
sse = fSSE(x',classes,3);
loss = sse/sst;
fprintf('IL: %f\n',loss*100);
fprintf('SSE: %f\n',sse);
fprintf('Time: %f\n\n',tempo1);
