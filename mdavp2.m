% Algoritmo MDAVP(Minha versão de MDAV 2) Baseado no centroide
% Proposto por Nielsen Castelo Damasceno (2014)
% Autor: Nielsen C. Damasceno
% Data: 23/04/2014
% Entrada:
%       x são as amostras
%       g é o número mínimo de cardinalidade
% Saída:
%       classes
function classes = mdavp2(x,g)
    classes = ones(1,size(x,1));
   
    card = size(x,1);
    k = 1;
    
    %% Passo 1: Calcule o centróide cx de todos os registros em x;
    pos = encontrar(classes,k); % Pega somente a posição da classe 1
    xx = x(pos,:);              % Pega os dados pertencente a classe 1
    cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
    
    %% Passo 2: Encontre o registro xr mais distante para o centróide cx;
    xr = find_elemento(xx,cx);
   
    %% Passo 3: Formar um cluster x' que contém os g - 1 registros mais próximo de xr;
    dist = distancias(xx,xr);
    ele = proximos(g,dist); % Pega os elementos mais próximos de xr
  
    %% Passo 4: Remova os registros de x
    k = k + 1;
    classes(pos([xr ele])) = k;
    card = card - g;    
    ci = cx;
    while(card >= g)
    
        %% Passo 5: Calcule o centroide ci
        posci = encontrar(classes,k);   % Pega somente a posição da classe k
        xxci = x(posci,:);              % Pega os dados pertencente a classe k
        subclasse = organiza(classes(posci));
        
        %% Passo 6: Encontre o elemento de xj mais distante do centroide ci
        posi = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(posi,:);              % Pega os dados pertencente a classe
        xj = find_elemento(xx,ci);
       
        %% Passo 7: Forme um cluster com o g-1 elemento mais próximo de xj
        dist2 = distancias(xx,xj);
        ele2 = proximos(g,dist2); % Pega os elementos mais próximos de xr
        
        %% Passo 8: Remova os registros de x
        k = k + 1;
        classes(posi([xj ele2])) = k;

        card = card - g; % Pega a cardinalidade de x
        
    end
    classes = organiza(classes);
    % Os registros xj que sobraram vão ser distribuidos para os outros clusters ci 
    % A partir da menor distância xj entre os centros xibar 
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
    if (~isempty(dist))    
        for i = 1 : length(pos)
            [~,po] = min(dist(i,:));
            classes(pos(i)) = po + 1;
        end
    end
    classes = organiza(classes);
    
end