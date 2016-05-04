%Todo: compute a speed profile. The output must be a structure that
%contains three arrays: The distance along path (s), desired velocity at
%every point in space, and desired acceleration at every point in space. 

function prof = generateSpeedTrajectory(path, veh)
    disp('Generating Speed');
    g = 9.81;
    ax = 0.2 * g;
    ay = 0.3 * g;
    Ux_max = 10;
    %%default code: just drive at 5 m/s (12 mph)
    prof.s = path.s;
    prof.Ux = min(Ux_max, sqrt(ay ./ path.K));
    prof.Ax = zeros(size(prof.s));
    
    Ux_temp = zeros(size(prof.s));
    Ux_temp2 = zeros(size(prof.s));
    Ux_temp(2) = sqrt(ax * prof.s(2) * 2);
    Ux_temp2(end - 1) = sqrt(ax * (prof.s(end) - prof.s(end-1)) * 2);
    
    for i = 3:size(prof.s, 1)
        %Ux_temp(i) = min(prof.Ux(i), Ux_temp(i - 1) + ax / Ux_temp(i - 1) * (prof.s(i) - prof.s(i - 1)));
        Ux_temp(i) = min(prof.Ux(i), sqrt(2 * ax * (prof.s(i) - prof.s(i-1)) + Ux_temp(i-1)^2));
    end
    prof.Ux = Ux_temp;
    for i = (size(prof.s, 1)-2):-1:1
        %Ux_temp2(i) = min(Ux_temp(i), Ux_temp2(i + 1) + ax / Ux_temp2(i + 1) * (prof.s(i + 1) - prof.s(i)));
        Ux_temp2(i) = min(Ux_temp(i), sqrt(2 * ax * (prof.s(i+1) - prof.s(i)) + Ux_temp2(i+1)^2));
    end
    
    prof.Ux = Ux_temp2;
    for i = 1:(size(prof.s, 1) - 1)
        dt = (prof.s(i+1) - prof.s(i)) / ((prof.Ux(i) + prof.Ux(i+1))/2);
        prof.Ax(i) = (prof.Ux(i+1) - prof.Ux(i)) / dt;
    end

%     figure;
%     plot(path.s, prof.Ux, 'r');
%     hold on;
%     plot(path.s, Ux_temp, 'b');
%     plot(path.s, Ux_temp2, 'm');
%     figure;
%     plot(path.s, prof.Ax);
%     prof.SpeedLimits = sqrt(maxLatAcc ./ path.K);
end
   