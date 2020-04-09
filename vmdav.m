% Algoritmo VMDAV (Maximum Distance Average Vector)
% Proposto por Agusti Solanas and Antoni Mart�?nez-Ballest (2006)
% do artigo (V-MDAV: A Multivariate Microaggregation
% With Variable Group Size)
% Autor: Nielsen C. Damasceno
% Data: 29/07/2014
% Entrada:
%       x s�o as amostras
%       g � o n�mero m�nimo de cada grupo
% Sa�da:
%       classes
%function classes = mdav(x,g)
    g = 3;
    x = company();
    n = size(x,1);
    classes = ones(1,n);

    k = 1;
    while(n > g)
        %% Passo 1: Calcule o centr�ide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posi��o da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
       
        %% Passo 2: Encontre o registro e mais distante para o centr�ide cx;
        e = find_elemento(xx,cx);
        
        %% Passo 3: Formar um cluster x' que cont�m os g - 1 registros mais pr�ximo de xr;
        dist = distancias(xx,e);
        ele = proximos(g,dist); % Pega os elementos mais pr�ximos de xr
        
        %% Passo 4: Remova os registros de x
        k = k + 1;
        classes(pos([e ele])) = k;
        
        %% Passo 5: Encontre o regitros n�o atribuido emin que � mais pr�ximo de qualquer um dos registros grupos
        %           atuais e defina como din a dist�ncia entre emin e o
        %           grupo
        posd1 = encontrar(classes,1); % Pega somente a posi��o da classe 1
        xx = x(posd1,:);                % Pega os dados pertencente a classe 1
        
        n = n - g; % Pega a cardinalidade de x
        
        %% Passo 5: Encontre o registro xs mais distante xr;
        xs = find_elemento(xx,xx(xr,:));
        
        %% Passo 6: Formar um cluster em x'que cont�m os g -1 registros mais pr�ximos de xs;
        dist = distancias(xx,xs);
        ele = proximos(g,dist); % Pega os elementos mais pr�ximos de xs
        
        %% Passo 7: Remova os registros de x
        k = k + 1;
        classes(pos([xs ele])) = k;
        
        n = n - g;
    end
    classes = organiza(classes);
    if(n >= g)
        %% Passo 8: Formar um cluster ci com os n registros restantes
        n = n - n;
       
    end
    
    if (n > 0)
        pos = encontrar(classes,1); % Pega somente a posi��o da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        %% Passo 9: Depois pega suas amostras Calcula seu centroide cx
        cx = centroideclass(xx,classes(pos)); 
        %% Passo 10: Localizar o centr�ide do cluster cj mais pr�ximo de cx
        centros = centroideclass(x,classes);
        
        cj = centro_proximo(centros,cx);
        
        %% Passo 11: Adicionar os registros restantes no cluster cj mais pr�ximo
        classes(pos) = cj;
        
    end
    classes = organiza(classes);