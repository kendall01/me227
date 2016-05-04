%Todo: compute a speed profile. The output must be a structure that
%contains three arrays: The distance along path (s), desired velocity at
%every point in space, and desired acceleration at every point in space. 

function prof = generateSpeedTrajectory(path, veh)
    disp('Generating Speed');
    
    %%default code: just drive at 5 m/s (12 mph)
    prof.s = path.s;
    prof.Ux = 5*ones(size(prof.s));
    prof.Ax = zeros(size(prof.s));
    
end
   