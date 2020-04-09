% Algoritmo MDAV3 (Maximum Distance Average Vector - single-group)
% Proposto por M.Laszlo & S. Mukherjee,(2005)
% do artigo (M.  Laszlo  &  S.  Mukherjee,  (2005)  “Minimum  spanning  tree  partitioning  algorithm  for 
% microaggregation”, IEEE Transactions on Knowledge and Data Engineering, 17(7), pp. 902-911.)
% Autor: Nielsen C. Damasceno
% Data: 06/04/2014
% Entrada:
%       x são as amostras
%       g é o número mínimo de cardinalidade
% Saída:
%       classes
function classes = mdav3(x,g)
    
    classes = ones(1,size(x,1));
  
    n = size(x,1);
    k = 1;
    while(n >= (3 * g))
        %% Passo 1: Calcule o centróide cx de todos os registros em x;
        pos = encontrar(classes,1); % Pega somente a posição da classe 1
        xx = x(pos,:);              % Pega os dados pertencente a classe 1
        cx = centroideclass(xx,classes(pos)); % Depois pega suas amostras Calcula seu centroide
        
        %% Passo 2: Encontre o registro xr mais distante para o centróide cx;
        xr = find_elemento(xx,cx);
       
        %% Passo 4: Formar um cluster x' que contém os g - 1 registros mais próximo de xr;
        dist = distancias(xx,xr);
        if dist == 0
            disp('ok');
        end
        ele = proximos(g,dist); % Pega os elementos mais próximos de xr
        
        %% Passo 5: Remova os registros de x
        k = k + 1;
        classes(pos([xr ele])) = k;
        
        n = n - g; % Pega a cardinalidade de x
       
    end
 
    if(n >= 2*g)
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

    end
    classes = organiza(classes);

end