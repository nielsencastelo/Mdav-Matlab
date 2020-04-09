
% Função que encontra o elemento xr mais próximo de cx
% Data: 15/04/2013
% Autor: Nielsen C. Damasceno
% Entrada:      x - são as amostras
%               cx - são os centros
% Saída:        xr - é a posição onde se encontra o elemento
function xr = centro_proximo(x,cx)
    [lin,~] = size(x);
    dist = zeros(lin,1);
    for i = 1 : lin
        dist(i) = sqrt((x(i,:)- cx)*(x(i,:)- cx)');
    end
    [~,xr] = min(dist);
end