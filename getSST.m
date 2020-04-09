function [SST] = getSST(Data)

    nodes = [1:1:size(Data,1)];
    m = mean(Data(nodes,:));
    L = length(nodes);
    SST = sum(sum((Data(nodes,:)- ones(L,1)*m).^2));
end