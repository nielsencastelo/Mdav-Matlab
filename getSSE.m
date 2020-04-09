function [SSE] = getSSE(Data,nodes)

    m = mean(Data(nodes,:));
    L = length(nodes);
    SSE = sum(sum((Data(nodes,:)- ones(L,1)*m).^2));
end