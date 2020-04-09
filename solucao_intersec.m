% Função que verifica a interseção entre as soluções, ou seja, verifica
% quais os clusters que não se modificaram na solução
% Data: 14/04/2014
% Autor: Nielsen C. Damasceno
% Entrada: x é a matriz (nxd)com as soluções. 
%          Cada coluna dessa matriz é uma solução
% Saída:    
%       clusters são os grupos que se repetem nas soluções
function cluster = solucao_intersec(x)

    %x1 = [1 1 2 2 3 4];
    %x2 = [1 1 2 1 3 4]; 
    %x3 = [1 1 2 1 2 3];
    %x = [x1;x2;x3];
    [lin,col] = size(x);
    contg = 1;
    cluster = zeros(1);
    teste = zeros(lin,col);
    k = max(max(x)); %  Pega o numero máximo de classes em toda solução

    for c = 1 : k
        cont = 1;
        for i = 1 : lin
            teste(i,:) = x(i,:) == c;
        end
        validador = teste(1,:);
        for i = 2 : lin
            if teste(i,:) == validador
                cont = cont + 1;
            end
        end
        if cont == lin % Se todas as classes forem iguais guarde o grupo
            cluster(contg) = c;
            contg = contg + 1;
        end
    end    
end