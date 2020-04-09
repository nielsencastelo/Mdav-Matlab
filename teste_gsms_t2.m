clear;clc;close all;

%x = company();
x = ler_tarragona();
%x = ler_census();
%x = ler_eia2();
g = 3;
%tic;
[sse, L, P, numC,classes] = GSMS_T2(x,g,1);
%tempo = toc;

%fprintf('IL: %f\n',L*100);
%fprintf('SSE Mdav: %f\n',sse);
%fprintf('Time: %f\n',tempo);

%save('tarragona_g3.txt','classes', '-ascii','-double');
%dlmwrite('tarragona_g3.txt',classes,'-append','roffset',1,'delimiter',' ');
%dlmwrite('eia_g3.txt',classes,'delimiter',' ','precision',10);

%% Testando o problema da base eia
% load eia_dados
% Data = x;
% % Fazer o N
% for i = 1 : numC
%     cont = 0;
%     for j = 1 : 9
%         if P(i,j) == 0
%             break;
%         end
%         cont = cont + 1;
%     end
%     N(i,:) = cont;
% end
% classes = zeros(1,size(Data,1));
% for i = 1 : numC
%     pos = P(i,1:N(i));
%     classes(1,pos) = i;
% end
% 
% [valor, posicao]= min(classes);
