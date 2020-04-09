
% Fun��o que encontra o elemento xr mais pr�ximo de cx
% Data: 15/04/2013
% Autor: Nielsen C. Damasceno
% Entrada:      x - s�o as amostras
%               cx - s�o os centros
% Sa�da:        xr - � a posi��o onde se encontra o elemento
function xr = centro_proximo(x,cx)
    [lin,~] = size(x);
    dist = zeros(lin,1);
    for i = 1 : lin
        dist(i) = sqrt((x(i,:)- cx)*(x(i,:)- cx)');
    end
    [~,xr] = min(dist);
end