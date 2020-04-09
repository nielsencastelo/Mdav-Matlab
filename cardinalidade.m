% Função que verifica a quantidade de objetos em cada classes
% Data: 14/01/2014
% Autor: Nielsen C. Damasceno
% Entrada: classes - são o conjunto de todas as classes
%          tipo - qual é a classes que deseja verificar 
% Saída: card - é a quantidade de objetos existente na classe tipo

function card = cardinalidade(classes,tipo)
    tam = length(classes);
    card = 0;
    for i = 1 : tam
        if classes(i) == tipo
            card = card + 1;
        end
    end
end