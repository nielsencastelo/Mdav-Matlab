% Algoritmo MD(Maximum Distance)
% Proposto por J. Domingo-Ferrer and J. M. Mateo-Sanz
% Do artigo (J. Domingo-Ferrer and J. M. Mateo-Sanz. 
% Practical data-oriented microaggregation for statistical 
% disclosure control. IEEE Transactions on Knowledge and
% Data Engineering, 14(1):189–201, 2002)

% Autor: Nielsen C. Damasceno
% Data: 24/04/2014
% Entrada:
%       x são as amostras
%       g é o número mínimo de cardinalidade
% Saída:
%       classes
function classes = md(x,g)
    classes = ones(1,size(x,1));

    
    pos = encontrar(classes,1); % Pega somente a posição da classe 1
    xx = x(pos,:);              % Pega os dados pertencente a classe 1
    subclass = classes(pos);
    cx = centroideclass(xx,subclass); % Depois pega suas amostras Calcula seu centroide
       
    k = 1;   
    card = size(x,1);
    while(card >= (2 * g))
        %% Passo 1: Calcule o centróide cx de todos os registros em x;
        %plotaCentroide(cx,'red');
        %% Passo 2: Encontre o registro xr mais distante para o centróide cx;
        xr = find_elemento(xx,cx);
        
        %% Passo 3: Encontre o registro xs mais distante xr;
        xs = find_elemento(xx,xx(xr,:));
        
        %% Passo 4: Formar um cluster x' que contém os g - 1 registros mais próximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
        
        %% Passo 5: Remova os registros de x
        k = k + 1;
        %classes(pos([xr ele])) = k + 1;
        
        classes(pos(xr)) = k; % Versão C++
        for i = 1 : g - 1
            classes(pos(ele(i))) = k;
        end
        
        %% Passo 6: Formar um cluster em x'que contém os g-1 registros mais próximos de xs;
        dist = distancias(xx,xs);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xs
        
        %% Passo 7: Remova os registros de x
        k =  k + 1;
        
        %classes(pos([xs ele])) = k + 1;
        classes(pos(xs)) = k; % Versão C++
        for i = 1 : g - 1
            classes(pos(ele(i))) = k;
        end
        
        card = card - g * 2;
       
    end
    if (card >= k) && (card <= (2 * g) - 1)
        % Forma um novo grupo como ponto de saída do algoritmo.
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        subclass = classes(pos);
        cx = centroideclass(xx,subclass); % Depois pega suas amostras Calcula seu centroide
        
        %% Encontre o registro xr mais distante para o centróide cx;
        xr = find_elemento(xx,cx);
        
        %% Formar um cluster x' que contém os g - 1 registros mais próximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
        
        %% Passo 5: Remova os registros de x
        k = k + 1;
        %classes(pos([xr ele])) = k + 1;
        classes(pos(xr)) = k; % Versão C++
        for i = 1 : g - 1
            classes(pos(ele(i))) = k;
        end
        card = card - g;
    end
    % Se houver menos de g registros que não pertencem a nenhum dos grupos 
    % formado na etapa 1,  adicione-os ao grupo mais próximo
    if card < g
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
    end
    classes = organiza(classes);
end