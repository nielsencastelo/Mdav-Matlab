% Algoritmo cbfs - centroide baseado no tamanho fixo (CENTROID-BASED FIXED-SIZE MICROAGGREGATION)
% Proposto por Laszlo, M., Mukherjee(2005)
% do artigo (Minimum spanning tree partitioning algorithm for microaggregation.
% IEEE Trans. Knowl. Data Eng. 17(7), 902�911 (2005))
% Autor: Nielsen C. Damasceno
% Data: 17/10/2014
% Entrada:
%       x s�o as amostras
%       g � o n�mero m�nimo de cardinalidade
% Sa�da:
%       classes
function classes = cbfs(x,g)
    
    classes = ones(1,size(x,1));
    card = size(x,1);
    k = 1;
    while(card >= g)
        %% Passo 1: Calcule o centr�ide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posi��o da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        subclass = classes(pos);
        cx = centroideclass(xx,subclass); % Depois pega suas amostras Calcula seu centroide
      
        %% Passo 2: Encontre o registro xr mais distante para o centr�ide cx;
        xr = find_elemento(xx,cx);
             
        %% Passo 3: Formar um cluster x' que cont�m os g - 1 registros mais pr�ximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais pr�ximos de xr
        
        %% Passo 4: Remova os registros de x
        k = k + 1;        
        classes(pos(xr)) = k; % Vers�o C++
        for i = 1 : g - 1
            classes(pos(ele(i))) = k;
        end
          
        card = card - g;
    end
    classes = organiza(classes);
    % Os registros que sobraram v�o ser distribuidos para os outros clusters ci 
    % A partir da menor dist�ncia entre os centros xibar e cada ponto
    centros = centroideclass(x,classes);
    centros = centros(2:end,:); % Remove o centro da classe 1
    pos = encontrar(classes,1); % Pega a posi��o dos registros em X
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
    temp = zeros(1,k);    
    for i = 1 : length(pos)
        for c = 1 : k
            temp(c) = dist(i,c);
        end
         [~,po] = min(temp);
         classes(pos(i)) = po + 1;
    end
    classes = organiza(classes);
end