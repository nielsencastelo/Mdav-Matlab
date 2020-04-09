% Fun��o que verifica a quantidade de objetos em cada classes
% Data: 14/01/2014
% Autor: Nielsen C. Damasceno
% Entrada: classes - s�o o conjunto de todas as classes
%          tipo - qual � a classes que deseja verificar 
% Sa�da: card - � a quantidade de objetos existente na classe tipo

function card = cardinalidade(classes,tipo)
    tam = length(classes);
    card = 0;
    for i = 1 : tam
        if classes(i) == tipo
            card = card + 1;
        end
    end
end