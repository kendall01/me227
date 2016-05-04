function world = genWorldFromSK(s, k)

    world.primitive_s = s;
    world.primitive_k = k;
    world.road_IC = [0; 0; 0];
    world = generateMap(world);

end