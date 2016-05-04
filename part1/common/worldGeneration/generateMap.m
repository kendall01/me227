function [ world ] = generateMap( world )
% s is path length, heading is theta, absolute angle

options = odeset('RelTol',1e-5,'MaxStep',1);
[s,z] = ode45(@curvatureProp,[0 world.primitive_s(end)],world.road_IC,options);

world.s = s;
world.roadPsi = z(:,1);
world.roadE = z(:,2);
world.roadN = z(:,3);

world.K = zeros(size(world.s));
for i = 1:numel(world.K)
    world.K(i) = interp1(world.primitive_s, world.primitive_k, s(i));
end

%plot(z(:,2),z(:,3))
%plot(s1,z(:,1))


    function [ dZ ] = curvatureProp( s,Z )
        K = interp1(world.primitive_s,world.primitive_k,s);
        theta = Z(1);
        % for theta CCW from N
        dZ = [K;-sin(theta);cos(theta)];
        
    end

end

