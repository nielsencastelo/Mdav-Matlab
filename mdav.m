% Algoritmo MDAV (Maximum Distance Average Vector)
% Proposto por J.Domingo-Ferrer e V.Torra (2005)
% do artigo (“Ordinal, continuous and heterogenerous k-anonymity 
% through microaggregation”, Data Mining Knowl. Discov. 11(2), pp. 195-212.)
% MDAV inicializa as classes para um determinado g
% Autor: Nielsen C. Damasceno
% Data: 14/01/2014
% Entrada:
%       x são as amostras
%       g é o número mínimo de cardinalidade
% Saída:
%       classes
function classes = mdav(x,g)
    
    classes = ones(1,size(x,1));

%     maxClass = ver_classes(x);
%     colors = rand(maxClass,3);
%     plota(x,classes,colors);
    card = cardinalidade(classes,1);
    classes = organiza(classes);
    while(card >= (3 * g))
        %% Passo 1: Calcule o centróide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        subclass = classes(pos);
        cx = centroideclass(xx,subclass); % Depois pega suas amostras Calcula seu centroide
        %plotaCentroide(cx,'red');
        %% Passo 2: Encontre o registro xr mais distante para o centróide cx;
        xr = find_elemento(xx,cx);
        
        %plotaCentroide(x(xr,:),'green');% Plota xr
        %% Passo 3: Encontre o registro xs mais distante xr;
        xs = find_elemento(xx,xx(xr,:));
        
        %plotaCentroide(x(xs,:),'blue');% Plota xs
        %% Passo 4: Formar um cluster x' que contém os g - 1 registros mais próximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
        
        %plotaCentroide(x(ele,:),'green');% Plota xr
        %% Passo 5: Remova os registros de x
        k = max(classes);
        %classes(pos([xr ele])) = k + 1;
        
        classes(pos(xr)) = k + 1; % Versão C++
        for i = 1 : g - 1
            classes(pos(ele(i))) = k + 1;
        end
        
        %% Passo 6: Formar um cluster em x'que contém os g -1 registros mais próximos de xs;
        dist = distancias(xx,xs);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xs
        
        %plotaCentroide(x(ele,:),'blue');% Plota xr
        %% Passo 7: Remova os registros de x
        k = max(classes);
        
        %classes(pos([xs ele])) = k + 1;
        classes(pos(xs)) = k + 1; % Versão C++
        for i = 1 : g - 1
            classes(pos(ele(i))) = k + 1;
        end
        
        card = cardinalidade(classes,1); % Pega a cardinalidade de x
        %sse = fSSE(x,classes,g);
        %fprintf('SSE: %f\n',sse);
        %fprintf('Card: %d\n',card);
        %clc;
    end
   
    if(card >= (2 * g))
        %% Passo 8: Calcule o centroide cx do registro x;
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
        %plotaCentroide(cx,'red');
        %% Passo 9: Localizar o registro xr mais distante para o centroide cx
        xr = find_elemento(xx,cx);
        %plotaCentroide(xx(xr,:),'yellow');% Plota xr
        %% Passo 10: Formar um cluster em x' com xr e os g - 1 registros mais próximos de xr
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
        %plotaCentroide(xx(ele,:),'yellow');% Plota xr
        %% Remova os registros de x
        k = max(classes);
        classes(pos([xr ele])) = k + 1;
        %card = cardinalidade(classes,1); % Pega a cardinalidade de x
        %sse = fSSE(x,classes,g);
        %fprintf('SSE: %f\n',sse);
    end

    % Formar outro cluster em x' com os registros restantes

    % para cada cluster q em x' faça
    % Calcule o centróide cq para todos os registors em q
    % Substituir todos os registros de q em x' com seu centróide cq
    % end for
    
    % Mostra resultados
    %maxClass = ver_classes(x);
    %colors = rand(maxClass,3);
    %plota(x,classes,colors);
    %c = centroide(x,classes);
    %plotaCentroide(c);
    classes = organiza(classes);
end