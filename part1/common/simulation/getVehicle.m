function veh = getVehicle(vehicleName)
    veh.a = 1.0441;
    veh.b = 1.4248;
    veh.m = 1.648e3;
    veh.Cf = 200000;
    veh.Cr = 200000;
    veh.Iz = 2.25e3;
    veh.muP = .8;
    veh.muS = .8;
    veh.g = 9.81;
    veh.L = veh.a + veh.b;
    veh.FzF = veh.m*veh.b*veh.g/veh.L;
    veh.FzR = veh.m*veh.a*veh.g/veh.L;
    
    veh.alphaFslide = abs( atan(3*veh.muP*veh.m*veh.b/veh.L*veh.g/veh.Cf) );
    veh.alphaRslide = abs( atan(3*veh.muP*veh.m*veh.a/veh.L*veh.g/veh.Cr) );
    
    veh.alphaFrontTable=[-veh.alphaFslide:.01:veh.alphaFslide];   % vector of front alpha (rad)
    veh.alphaRearTable =[-veh.alphaRslide:.01:veh.alphaRslide];   % vector of rear alpha (rad)
    
    veh.FyFtable = tireforces(veh.Cf,veh.muP,veh.muS,veh.alphaFrontTable,veh.FzF);
    veh.FyRtable = tireforces(veh.Cf,veh.muP,veh.muS, veh.alphaRearTable,veh.FzR);
    
    veh.fdrag = .3638; %N/(m/s^2);
    veh.frr   = 255; %rolling resistance, N
    
end