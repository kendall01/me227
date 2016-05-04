function animateSimResults(sim, world, veh)

figure;
    
for i = 1:15:sim.N
    plotVehicle(sim.posE(i), sim.posN(i), sim.psi(i), sim.delta(i), veh);
    axis equal; grid on;
    xlim( [ sim.posE(i)-5 sim.posE(i)+5 ]);
    ylim( [ sim.posN(i)-5 sim.posN(i)+5 ]);

    hold on;
    plot(world.roadE, world.roadN,'k--','LineWidth',2);
    hold off;
    pause(.001);
    
end