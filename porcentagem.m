% Função que calcula a quantidade de cluster encontrado em porcentagem
% a partir da matriz de incidência
% Data: 29/04/2014
% Autor: Nielsen C. Damasceno
% Entrada: t é matriz de incidência
% Saída:   por é o resultado em porcentagem
% Exemplo:
%           t =  [0 3 0 0 0; ...  
%                 0 0 0 0 0; ...
%                 0 0 0 3 0; ...  
%                 0 0 0 0 2; ...  
%                 0 0 0 0 0];
%           >> por = 66.6667
function por = porcentagem(t)
           
    [lin,~] = size(t);
    num = max(max(t));
    difzero = 0;
    cont = 0;
    for i = 1 : lin
        for j = 1 : lin
            if t(i,j) ~= 0 
                difzero = difzero + 1;
            end
            if (t(i,j) == num) && (t(i,j) ~= 0)
                cont = cont + 1;
            end
        end
    end
    por = (100 * cont)/difzero;
end