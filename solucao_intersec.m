% Fun��o que verifica a interse��o entre as solu��es, ou seja, verifica
% quais os clusters que n�o se modificaram na solu��o
% Data: 14/04/2014
% Autor: Nielsen C. Damasceno
% Entrada: x � a matriz (nxd)com as solu��es. 
%          Cada coluna dessa matriz � uma solu��o
% Sa�da:    
%       clusters s�o os grupos que se repetem nas solu��es
function cluster = solucao_intersec(x)

    %x1 = [1 1 2 2 3 4];
    %x2 = [1 1 2 1 3 4]; 
    %x3 = [1 1 2 1 2 3];
    %x = [x1;x2;x3];
    [lin,col] = size(x);
    contg = 1;
    cluster = zeros(1);
    teste = zeros(lin,col);
    k = max(max(x)); %  Pega o numero m�ximo de classes em toda solu��o

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