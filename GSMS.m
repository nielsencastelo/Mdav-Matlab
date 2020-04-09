% Algoritmo GSMS (Successive Group Selection for Microaggregatio)
% Proposto por C. Panagiotakis and G. Tziritas
% Autor: Nielsen C. Damasceno
% Data: 02/04/2014
% Entrada:
%       Data: N x p matriz de amostras com N registros
%             e p atributos 
%       K: é a cardinalidade minima para cada grupo (parametro da
%       Microagregação) também conhecido como g
% Saída:
%       SSE: soma do erro quadrado intra-partição(SSE)
%       L: medida a perda de informações padronizadas 
%       numC: Número de Clusters (grupos)
%       P: Partição na forma matricial. O número de linhas da matriz são numC 

function [SSE, L, P, numC] = GSMS(Data,K)
    n = size(Data,1);
    Dist = zeros(n,n);
    Dist_sorted = zeros(n,n);
    Dist_pos = zeros(n,n);
    for i = 1: n,
        for j=i+1:n,
            Dist(i,j) = norm(Data(i,:)-Data(j,:))^2;
            Dist(j,i) = Dist(i,j);
        end
        [Dist_sorted(i,:),Dist_pos(i,:)] = sort(Dist(i,:)); 
    end


    SET = 1:n;
    N = zeros(floor(n/K),1);
    P = zeros(floor(n/K),K);

    for i = 1:floor(n/K),
        Error = zeros(length(SET),1);
        for j = 1:length(SET),
            node = SET(j);
            [vec pos] = intersect(Dist_pos(node,:),SET);
            [temp, pos] = sort(pos);
            vec = vec(pos);
            nodes1 = vec(1:K);
        
            nodes2 = setdiff(SET,nodes1);
            Error(j) = getSSE(Data,nodes1)+getSSE(Data,nodes2);
        
        end
       [temp,j] = min(Error);
        node = SET(j);
        [vec pos] = intersect(Dist_pos(node,:),SET);
        [temp, pos] = sort(pos);
        vec = vec(pos);
        vec = vec(1:K);

        N(i) = K;
        P(i,1:K) = vec;
        SET = setdiff(SET,vec);
    end

    Centroints = zeros(floor(n/K),size(Data,2));
    if ~isempty(SET),
    
        for i=1:floor(n/K),
            Centroints(i,:) =  mean(Data(P(i,1:K),:));
        end
    
        d = zeros(floor(n/K),length(SET));
        for i = 1:floor(n/K),
            for j=1:length(SET),
                d(i,j) = norm(Centroints(i,:)-Data(SET(j),:));
            end
        end
    
        for j = 1:length(SET),
            [temp, pos] = min(d(:,j));
            P(pos,N(pos)+1) = SET(j);
            N(pos) = N(pos)+1;
        end
    
    end

    numC = floor(n/K);
    SSE = 0;
    for i1 = 1:numC,
        SSE = SSE + getSSE(Data,P(i1,1:N(i1)));
    end

    SST = getSST(Data);
    L = SSE/SST;

end