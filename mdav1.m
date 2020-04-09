% Algoritmo MDAV1 (Maximum Distance Average Vector)
% Proposto por J. Domingo-Ferrer, A. Solanas & A. Mat�_nez-Ballest�e (2006)
% do artigo (J.  Domingo-Ferrer, A. Solanas & A. Mat�_nez-Ballest�e, 2006
% �Privacy  in  statistical  databases:  k-anonymity through microaggregation�,
% in IEEE Granular Computing' 06. Atlanta. USA, pp. 774-777.)
% Autor: Nielsen C. Damasceno
% Data: 04/04/2014
% Entrada:
%       x s�o as amostras
%       g � o n�mero m�nimo de cardinalidade
% Sa�da:
%       classes
function classes = mdav1(x,g)
    n = size(x,1);
    classes = ones(1,n);
   
    
    k = 1;
    while(n >= (2 * g))
        %% Passo 1: Calcule o centr�ide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posi��o da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
       
        %% Passo 2: Encontre o registro xr mais distante para o centr�ide cx;
        xr = find_elemento(xx,cx);
        
        %% Passo 3: Formar um cluster x' que cont�m os g - 1 registros mais pr�ximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais pr�ximos de xr
        
        %% Passo 4: Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
        
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
end