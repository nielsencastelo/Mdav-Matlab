% Função que encontra os g - 1 elementos mais próximos
% baseado na distancia
% Data: 15/04/2013
% Autor: Nielsen C. Damasceno
% Entrada:      g - é o número mínimo de cluster
%               dist é o vetor com as distâncias
% Saída:        ele - são os elementos mais próximos
function elemento = proximos(g,dist)
%     ele = zeros(1,g-1);
    if length(dist)== g-1
        elemento = 1 : g - 1;
        return;
    end
    
%     for i = 1 : g - 1
%         pos = find(dist ~= 0);       % Pega os elementos diferentes de zero
%         if isempty(dist)
%             disp('Vazia');
%         end
%         [~,ele(i)] = min(dist(pos)); % Pega o menor e retorna sua posição
%         [ele(i)] = pos(ele(i));
%         dist(ele(i)) = 0;            % Foi localizado agora ele será zerado
%     end
    
    % Versão C++
    elemento = zeros(1,g-1);
    for i = 1 : g - 1
        cont = 1;
        pos2 = zeros;
        for j = 1 : length(dist)% Pega os elementos diferentes de zero
            if dist(j) ~= 0
                pos2(cont) = j;
                cont = cont + 1;
            end
        end
        % Indexa as amostras para pegar o menor elemento
        distx = zeros;
        for id = 1 : length(pos2) % dist(pos)
            distx(id) = dist(pos2(id));
        end
         [~,elemento(i)] = min(distx);   % Pega o menor e retorna sua posição
         elemento(i) = pos2(elemento(i));
         dist(elemento(i)) = 0;            % Foi localizado agora ele será zerado
    end
end