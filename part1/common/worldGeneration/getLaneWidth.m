%given a map and a point cloud of the road edge
%finds the permissible width the car can go without running
%off the road

function worldOut = getLaneWidth(world, bounds, buffer)
    disp('Getting Lane Boundaries')
    worldOut = world;
    clear getMinDistance 
    
    n = numel(world.roadE);
    widthLeft = zeros(n, 1);
    widthRight = zeros(n, 1);
        
    for i = 1:n
        widthLeft(i) = getMinDistance([world.roadE(i) world.roadN(i)], bounds.in)-buffer;
    end
    
    for i = 1:n
        widthRight(i) = -(getMinDistance([world.roadE(i) world.roadN(i)], bounds.out) - buffer);
    end
    
    worldOut.widthLeft = widthLeft;
    worldOut.widthRight = widthRight;
    
end
        