function Fx = longitudinalDynamics(FxCommand, Ux, veh)
    Fx = FxCommand - sign(Ux)*veh.fdrag*Ux^2 - veh.frr*sign(Ux);
end
    
    