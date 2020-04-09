% Microagregação (Exemplo analitico do artigo para o calculo do sse)
% Valor exato do sse = 7.484
% valor exato do loss = 0.34
clear;close all;clc;
%x = [1; 1; 2; 3; 4; 10; 11; 12; 12];
%y = [1; 4; 6; 3; 2; 10; 14; 12; 9];
%classes = [1 1 1 1 1 2 2 2 2];

sup    = [790; 710; 730; 810; 950; 510; 400; 330; 510; 760; 50];
%sup = sup/norm(sup);
supn = (sup - mean(sup))/std(sup);
    
emp = [55;  44;   32;  17;   3;  25;  45;  50;   5;  52; 12];  
    %emp = emp/norm(emp);
empn = (emp - mean(emp))/std(emp);
v = [supn empn];
x = [sup emp];

classes = [1 1 1 2 2 3 3 3 2 1 3];
k = ver_classes(classes); % Quantidade de classes

%colors = rand(k,3);
%plota(v,classes,colors);


%% 1ª versão do calculo analitico
% xbar = zeros(3,2);
% % Calcula as médias (xi_bar) de cada grupo
% for j = 1 : k           
%      xbar(j,:) = mean(v(encontrar(classes,j),:));
% end
% 
% % para x1j
% x1j = v(encontrar(classes,1),:);
% sse1 = 0;
% for j = 1 : 4
%    sse1 = sse1 + (x1j(j,:) - xbar(1,:)) * (x1j(j,:) - xbar(1,:))';
% end
% 
% % para x2j
% x2j = v(encontrar(classes,2),:);
% sse2 = 0;
% for j = 1 : 3
%    sse2 = sse2 + (x2j(j,:) - xbar(2,:)) * (x2j(j,:) - xbar(2,:))';
% end
% 
% % para x3j
% x3j = v(encontrar(classes,3),:);
% sse3 = 0;
% for j = 1 : 4
%    sse3 = sse3 + (x3j(j,:) - xbar(3,:)) * (x3j(j,:) - xbar(3,:))';
% end
% 
% disp(sse1 + sse2 + sse3);

%% 2ª versão do calculo do sse (calculo de cada atributo)
xbar = zeros(3,1);
% Calcula as médias (xi_bar) de cada grupo
for j = 1 : k           
     xbar(j) = mean(v(encontrar(classes,j),1));
end

% para x1j atributo 1
x1j = v(encontrar(classes,1),1);
sse1 = 0;
for j = 1 : length(x1j)
   sse1 = sse1 + (x1j(j,:) - xbar(1,:))' * (x1j(j,:) - xbar(1,:));
end

% para x2j atributo 1
x2j = v(encontrar(classes,2),1);
sse2 = 0;
for j = 1 : length(x2j)
   sse2 = sse2 + (x2j(j,:) - xbar(2,:))' * (x2j(j,:) - xbar(2,:));
end

% para x3j atributo 1
x3j = v(encontrar(classes,3),1);
sse3 = 0;
for j = 1 : length(x3j)
   sse3 = sse3 + (x3j(j,:) - xbar(3,:))' * (x3j(j,:) - xbar(3,:));
end

ssep1 = (sse1 + sse2 + sse3);


% Calculo do atributo 2
xbar = zeros(3,1);
% Calcula as médias (xi_bar) de cada grupo
for j = 1 : k           
     xbar(j) = mean(v(encontrar(classes,j),2));
end

% para x1j atributo 2
x1j = v(encontrar(classes,1),2);
sse1 = 0;
for j = 1 : length(x1j)
   sse1 = sse1 + (x1j(j,:) - xbar(1,:))' * (x1j(j,:) - xbar(1,:));
end

% para x2j atributo 2
x2j = v(encontrar(classes,2),2);
sse2 = 0;
for j = 1 : length(x2j)
   sse2 = sse2 + (x2j(j,:) - xbar(2,:))' * (x2j(j,:) - xbar(2,:));
end

% para x3j atributo 2
x3j = v(encontrar(classes,3),2);
sse3 = 0;
for j = 1 : length(x3j)
   sse3 = sse3 + (x3j(j,:) - xbar(3,:))' * (x3j(j,:) - xbar(3,:));
end

ssep2 = (sse1 + sse2 + sse3);
% Calculo do SSE
sse = ssep1 + ssep2; 

% Calculo do SST
xbar = mean(v);
sst = 0;
for i = 1 : 11
    sst = sst + ((v(i,:)-xbar) * (v(i,:)-xbar)');
end

loss = sse/sst;

fprintf('SSE %f\n',sse);
fprintf('IL: %f\n',loss);
