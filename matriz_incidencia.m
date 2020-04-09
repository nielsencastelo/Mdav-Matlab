% Fun��o que calcula a matriz de incid�ncia da solu��o
% Data: 09/05/2014
% Autor: Nielsen C. Damasceno
% Entrada: x � � uma matriz (1xn) com uma solu��o 
% Sa�da:    
%       matriz � matriz de incid�ncia
% as linhas s�o as classes e as colunas os registros a qual perten�e
% Exemplo:
%   solu��o = [2 2 1 1 1]
%
%              1 2 3 4 5 
%              ---------
%           1 |0 1 0 0 0  % Cluster 2 na posi��o 1 e 2 da solu��o
%           2 |0 0 0 0 0
%           3 |0 0 0 1 0  % Cluster 1 na posi��o 3 e 4 da solu��o
%           4 |0 0 0 0 1  % Cluster 1 na posi��o 4 e 5 da solu��o
%           5 |0 0 0 0 0

function matriz = matriz_incidencia(x)

    %x = [2 2 1 1 1];
    nc = max(x);    % N�mero de classes
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