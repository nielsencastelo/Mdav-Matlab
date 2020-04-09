clear;clc;close all;
% Convertendo as amostras em txt

c = company(); 
% fid = fopen('company.txt','wt');
% fprintf(fid,'%.17f\n',c);
% fclose(fid);

t = ler_tarragona();
% fid = fopen('tarragona.txt','wt');
% fprintf(fid,'%.17f\n',t);
% fclose(fid);
% 
ce = ler_census();
% fid = fopen('census.txt','wt');
% fprintf(fid,'%f\n',ce);
% fclose(fid);
% 
e2 = ler_eia2();
% fid = fopen('eia2.txt','wt');
% fprintf(fid,'%f\n',e2);
% fclose(fid);

e3 = ler_forest();

save company.txt c -ascii
save tarragona.txt t -ascii
save cencus.txt ce -ascii
save eia2.txt e2 -ascii
save forest.txt e3 -ascii