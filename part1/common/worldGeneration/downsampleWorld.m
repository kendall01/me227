function [worldNew] = downsampleWorld(world, factor)
    N = numel(world.s);
    n = round(N/factor);
    
    ind = round(linspace(1, N, n));
    
    worldNew.s = world.s(ind);
    worldNew.roadPsi = world.roadPsi(ind);
    worldNew.roadE = world.roadE(ind);
    worldNew.roadN = world.roadN(ind);
    worldNew.K = world.K(ind);
    
    try
        worldNew.widthLeft = world.widthLeft(ind);
        worldNew.widthRight = world.widthRight(ind);
    catch
    end
end