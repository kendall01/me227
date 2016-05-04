function world = genWorldFromCSV(file)
    disp('Generating World From CSV ....')
    map = loadMapData(file);
    
    if map.cumLength(1) == 0
        world.primitive_s = [map.cumLength; map.totalLength];
    else
        world.primitive_s = [0; map.cumLength];
    end
    
    world.primitive_k = [map.kStart; map.kEnd(end)];
    
    world.road_IC = [map.psiInit(1)-pi/2; map.EInit(1); map.NInit(1)]; %csv's have 0 degrees defined due east due to GPS convention
    world = generateMap(world);

end