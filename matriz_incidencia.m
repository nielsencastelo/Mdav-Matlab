% Função que calcula a matriz de incidência da solução
% Data: 09/05/2014
% Autor: Nielsen C. Damasceno
% Entrada: x é é uma matriz (1xn) com uma solução 
% Saída:    
%       matriz é matriz de incidência
% as linhas são as classes e as colunas os registros a qual pertençe
% Exemplo:
%   solução = [2 2 1 1 1]
%
%              1 2 3 4 5 
%              ---------
%           1 |0 1 0 0 0  % Cluster 2 na posição 1 e 2 da solução
%           2 |0 0 0 0 0
%           3 |0 0 0 1 0  % Cluster 1 na posição 3 e 4 da solução
%           4 |0 0 0 0 1  % Cluster 1 na posição 4 e 5 da solução
%           5 |0 0 0 0 0

function matriz = matriz_incidencia(x)

    %x = [2 2 1 1 1];
    nc = max(x);    % Número de classes
    tam = length(x);% Tamanho das amostras
    matriz = zeros(tam,tam);
    for i = 1 : nc
        pos = encontrar(x,i);
        n = length(pos) - 1;
        for j = 1 : n
            lin = pos(j);
            col = pos(j+1);
            matriz(lin,col) = 1;
        end
    end
end