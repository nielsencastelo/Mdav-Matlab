function classes = viabilidade(x,classes)

    % Os pontos que sobraram vão ser distribuidos para os outros clusters ci 
    % A partir da menor distância de cada ponto entre os centroides
    centros = centroideclass(x,classes);
    centros = centros(2:end,:); % Remove o centro da classe 1
    pos = encontrar(classes,1); % Pega a posição dos registros em X
    d = x(pos,:);
     
    high = size(d,1);
    [k,~] = size(centros);
    dist = zeros(high,k);
    for var = 1:high
        for c = 1:k
            soma = 0;
            for s = 1:size(d,2)
                soma = soma + (d(var,s) - centros(c,s)).^2;
            end
            dist(var,c) = sqrt(soma);
        end
    end
        
    for i = 1 : length(pos)
        [~,po] = min(dist(i,:));
        classes(pos(i)) = po + 1;
    end
    classes = organiza(classes);
    maxClass = ver_classes(classes);          % ver a qtd de classes
    tamClass = qtd_classes(classes,maxClass); % cada linha é o nº de objetos na classe
end