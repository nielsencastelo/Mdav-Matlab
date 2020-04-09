% Algoritmo MDAVP(Minha versão de MDAV)
% Proposto por Nielsen Castelo Damasceno (2014)
% Autor: Nielsen C. Damasceno
% Data: 21/04/2014
% Entrada:
%       x são as amostras
%       g é o número mínimo de cardinalidade
% Saída:
%       classes
function classes = mdavp(x,g)
    
    classes = ones(1,size(x,1));
    card = size(x,1);
    k = 1;

    while(card >= (3 * g))
        %% Passo 1: Calcule o centróide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
      
        %% Passo 2: Encontre o registro xr mais distante para o centróide cx;
        xr = find_elemento(xx,cx);
     
        %% Passo 3: Encontre o registro xs mais distante xr;
        xs = find_elemento(xx,xx(xr,:));
      
        %% Passo 4: Formar um cluster x' que contém os g - 1 registros mais próximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
       
        %% Passo 5: Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
        %% Passo 6: Formar um cluster em x'que contém os g-1 registros mais próximos de xs;
        dist = distancias(xx,xs);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xs
      
        %% Passo 7: Remova os registros de x
        k = k + 1;
        classes(pos([xs ele])) = k;
        card = card - 2 * g; % Pega a cardinalidade de x
    end
    
    if(card >= (g))
        %% Passo 8: Calcule o centroide cx do registro x;
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
      
        %% Passo 9: Localizar o registro xr mais distante para o centroide cx
        xr = find_elemento(xx,cx);
     
        %% Passo 10: Formar um cluster em x' com xr e os g - 1 registros mais próximos de xr
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
       
        %% Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
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
    
    temp = zeros(1,k);
    if (~isempty(temp))
        for i = 1 : length(pos)
            for c = 1 : k
                temp(c) = dist(i,c);
            end
            [~,po] = min(temp);
            classes(pos(i)) = po + 1;
        end
    end
    classes = organiza(classes);
end