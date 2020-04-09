function [y,media,desvio] = normalizaDados(x)
    [lin, col] = size(x);
    media = mean(x);
    desvio = std(x);
    y = zeros(lin,col);
    for i = 1 : col
        y(:,i) = (x(:,i) - media(:,i))/desvio(:,i);
    end
end