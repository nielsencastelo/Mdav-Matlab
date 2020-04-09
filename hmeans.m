% Algoritmo h-means proposto por Späth (1980)
% Autor: Nielsen C. Damasceno
% Data: 09/04/2014
% Entrada:
%       x são as amostras
%       k é o número de centros
% Saída:
%       classes
function classes = hmeans(x,k)
    classes = constroi_classes(k,length(x));
    centros = centroide(x,classes);
    
    % Aqui começa o h-means calculando novos centroides utilizando Späth (1980)
    nova_classe = classes;
    for i = 1 : size(classes,2);
        nova_classe = classes;
        CL = nova_classe(i);
        for j = 1 : k
            nova_classe(i) = j;
            CI = j;
            numofclass = qtd_classes(nova_classe,k);
            NI = numofclass(CI);
            NL = numofclass(CL);
            XL_bar = centros(CL,:);
            XI_bar = centros(CI,:);
            XJ = x(classes(i),:);
            VIJ = ((NI/(NI + 1)) * norm(XI_bar - XJ).^2) - ((NL/(NL - 1)) * norm(XL_bar - XJ).^2);
            % se houver melhoria os centros são atualizados
            if VIJ < 0
                centros(CL,:) = ((NL * XL_bar) - XJ) / (NL - 1);
                centros(CI,:) = ((NI * XI_bar) + XJ) / (NI + 1);
            end
        end
    end

    % Se houve melhoria vamos atualizar a classes
    high = size(x,1);
    k = ver_classes(classes);
    dist = zeros(high,k);
    for var = 1:high
        for c = 1:k
            soma = 0;
            for s = 1:size(x,2)
                soma = soma + (x(var,s) - centros(c,s)).^2;
            end
            dist(var,c) = sqrt(soma);
        end
    end
    % Atribuindo as classes para os valores
    for var = 1:high
        [~,indice] = min(dist(var,:));
        classes(var) = indice;
    end

end