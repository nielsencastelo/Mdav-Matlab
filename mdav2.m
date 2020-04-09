% Algoritmo MDAV2 (Maximum Distance Average Vector)
% Proposto por Jun-Lin  Lin,  Tsung-Hsien  Wen,  Jui-Chien  Hsieh  &  Pei-Chann  Chang, (2010)
% do artigo (Jun-Lin  Lin,  Tsung-Hsien  Wen,  Jui-Chien  Hsieh  &  Pei-Chann  Chang,  (2010) 
% “Density-based microaggregation  for  statistical  disclosure  control”,  Expert  Systems 
% with  Application,  37(4),  pp.  3256-3263.)
% Autor: Nielsen C. Damasceno
% Data: 04/04/2014
% Entrada:
%       x são as amostras
%       g é o número mínimo de cardinalidade
% Saída:
%       classes
function classes = mdav2(x,g)
    
    classes = ones(1,size(x,1));
    
    n = size(x,1);
    k = 1;
    while(n > (2 * g))
        %% Passo 1: Calcule o centróide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
     
        %% Passo 2: Encontre o registro xr mais distante para o centróide cx;
        xr = find_elemento(xx,cx);
      
        %% Passo 4: Formar um cluster x' que contém os g - 1 registros mais próximo de xr;
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
     
        %% Passo 5: Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
        
        n = n - g; % Pega a cardinalidade de x
        
        %% Passo 3: Encontre o registro xs mais distante xr;
        xs = find_elemento(xx,xx(xr,:));
     
        %% Passo 6: Formar um cluster em x'que contém os g -1 registros mais próximos de xs;
        dist = distancias(xx,xs);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xs
     
        %% Passo 7: Remova os registros de x
        k = k + 1;
        classes(pos([xs ele])) = k;
        
        n = n - g;
      
    end
    classes = organiza(classes);
    if(n >= g)
        %% Passo 8: Calcule o centroide xbar do restante registro x;
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        xbar = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
      
        
        %% Passo 9: Localizar o registro xr mais distante para o centroide xbar
        xr = find_elemento(xx,xbar);
       
        
        %% Passo 10: Formar um cluster em x' com xr e os g - 1 registros mais próximos de xr
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
       
        %% Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
        
        n = n - g;
    end
    classes = organiza(classes);
    if (n > 0) % passo 4 do artigo
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        xbar = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
        %% Passo 11: Localizar o registro xr mais distante para o centroide xbar
        xr = find_elemento(xx,xbar);
      
         %% Passo 12: Formar um cluster em x' com xr e os g - 1 registros mais próximos de xr
        dist = distancias(xx,xr);
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
      
        %% Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
        
    end
    classes = organiza(classes);
   
end