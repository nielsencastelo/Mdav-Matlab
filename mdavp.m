% Algoritmo MDAVP(Minha vers�o de MDAV)
% Proposto por Nielsen Castelo Damasceno (2014)
% Autor: Nielsen C. Damasceno
% Data: 21/04/2014
% Entrada:
%       x s�o as amostras
%       g � o n�mero m�nimo de cardinalidade
% Sa�da:
%       classes
function classes = mdavp(x,g)
    
    classes = ones(1,size(x,1));
    card = size(x,1);
    k = 1;

    while(card >= (3 * g))
        %% Passo 1: Calcule o centr�ide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posi��o da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
      
        %% Passo 2: Encontre o registro xr mais distante para o centr�ide cx;
        xr = find_elemento(xx,cx);
     
        %% Passo 3: Encontre o registro xs mais distante xr;
        xs = find_elemento(xx,xx(xr,:));
      
        %% Passo 4: Formar um cluster x' que cont�m os g - 1 registros mais pr�ximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais pr�ximos de xr
       
        %% Passo 5: Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
        %% Passo 6: Formar um cluster em x'que cont�m os g-1 registros mais pr�ximos de xs;
        dist = distancias(xx,xs);
        ele = proximos(g,dist); % Pega os elementos mais pr�ximos de xs
      
        %% Passo 7: Remova os registros de x
        k = k + 1;
        classes(pos([xs ele])) = k;
        card = card - 2 * g; % Pega a cardinalidade de x
    end
    
    if(card >= (g))
        %% Passo 8: Calcule o centroide cx do registro x;
        pos = encontrar(classes,1); % Pega somente a posi��o da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
      
        %% Passo 9: Localizar o registro xr mais distante para o centroide cx
        xr = find_elemento(xx,cx);
     
        %% Passo 10: Formar um cluster em x' com xr e os g - 1 registros mais pr�ximos de xr
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais pr�ximos de xr
       
        %% Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
    end
    classes = organiza(classes);
     % Os registros xj que sobraram v�o ser distribuidos para os outros clusters ci 
     % A partir da menor dist�ncia xj entre os centros xibar 
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