%main workhorse of racing simulator - this is the main loop that simulates
%a bike model with Fiala tires. 

%You shouldn't need to do anything here.

function simout = bikeSim(world, veh, velocityProfile)
    
    %simulation time step
    ts = .005;

    %get start state - note that this assumes we start on the straight!!!
    Ux = 0; Uy = 0; r = 0;
    psi  = world.roadPsi(1);
    posE = world.roadE(1);
    posN = world.roadN(1);
    i = 0; t = 0;
    delta = 0; %need to specify to avoid algebraic loop in line 39.
    
    %clear mapMatch function to avoid mapMatching to previous iterations
    clear mapMatch
    
    while true

        %perform map matching   
        [e, dPsi, K, s] = mapMatch(posE, posN, psi, world); 
        

        %check to see if we are at the end of the map.
        if s > world.s(end) - 1; break; end
        
        %check to see if we have gone off the track
         if abs(e) > 5
             disp('Car has gone off the track')
             break;
         end
            
        %calculate our desired speed and acceleration.   
        AxDes = interp1(velocityProfile.s, velocityProfile.Ax, s);
        UxDes = interp1(velocityProfile.s, velocityProfile.Ux, s);
        
        %calculate tire slips and sideslip
        if Ux < 2
            alphaF = 0;
            alphaR = 0;
            beta   = 0;
        else
            alphaF = atan((Uy + veh.a*r)/Ux) - delta;
            alphaR = atan((Uy - veh.b*r)/Ux);
            beta   = atan(Uy/Ux);
        end

        %calculate steering and longitudinal inputs
        [delta, FxCommand] = controller(e, dPsi, K, s, AxDes, UxDes, alphaF, alphaR, Ux, beta, r, psi, posE, posN, world.s(end));

        %determine predicted forces
        Fx  = longitudinalDynamics(FxCommand, Ux, veh);
        FyF = tireforces(veh.Cf, veh.muP, veh.muS, alphaF, veh.FzF);
        FyR = tireforces(veh.Cr, veh.muP, veh.muS, alphaR, veh.FzR);
        
        %update states
        dUy = (FyF + FyR)/veh.m - r*Ux;
        dr = (veh.a*FyF - veh.b*FyR)/veh.Iz;
        dUx = Fx/veh.m;
        dE = -Uy*cos(psi)-Ux*sin(psi);
        dN = Ux*cos(psi) - Uy*sin(psi);
        dotPsi = r;

        Uy = Uy + ts*dUy;
        r  =  r + ts*dr;
        Ux = Ux + ts*dUx;
        posE = posE + ts*dE;
        posN = posN + ts*dN;
        psi  = psi  + ts*dotPsi;

        i = i + 1; t = t + ts;
        %display percent completion of simulation.
        if mod(i,100) == 0
            clc
            disp(['Simulation is ' num2str(ceil(100*s/world.s(end))) ' percent done'])
            disp(['Distance Along Path ' num2str(s) ' meters'])
        end
        
        simout.Ux(i) = Ux; simout.Uy(i) = Uy; simout.r(i) = r; simout.s(i) = s;
        simout.posE(i) = posE; simout.posN(i) = posN; simout.psi(i) = psi;
        simout.FyF(i) = FyF; simout.FyR(i) = FyR; simout.Fx(i) = Fx; simout.FxDes(i) = Fx;
        simout.delta(i) = delta; simout.t(i) = t; simout.beta(i) = atan(Uy/Ux); simout.e(i) = e; simout.dPsi(i) = dPsi;
        simout.alphaF(i) = alphaF; simout.alphaR(i) = alphaR; simout.N = numel(simout.t);
        
    end
    
    disp(['Lap Time Equals ' num2str(simout.t(end)) ' s'])
    disp(['Max Lateral Error Equals ' num2str(max(abs(simout.e))) ' m'])
end