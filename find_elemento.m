% Fun��o que encontra o elemento xr mais distante de cx
% Data: 15/04/2013
% Autor: Nielsen C. Damasceno
% Entrada:      x - s�o as amostras
%               cx - s�o os centros
% Sa�da:        xr - � a posi��o onde se encontra o elemento
function xr = find_elemento(x,cx)
    [lin,col] = size(x);
%     dist = zeros(lin,1);
%     for i = 1 : lin
%         dist(i) = sqrt((x(i,:)- cx)*(x(i,:)- cx)');
%     end
%     [~,xr] = max(dist);
    
    % Vers�o implementada para C++
    dis = zeros(lin,1);
    for i = 1 : lin
        soma = 0;
        for j = 1 : col
           %sub = x(i,j) - cx(j);
           %pot = sub * sub;
           %soma = soma + pot;
           soma = soma + (x(i,j) - cx(j)) * (x(i,j) - cx(j));
        end
        dis(i) = sqrt(soma);
    end
     [~,xr] = max(dis);
end