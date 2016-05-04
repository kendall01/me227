%To do: Write a steering and longitudinal controller. The function takes in
%all the inputs which you may assume the TTS will provide you. These are
%labeled as follows:

%e: lateral offfset from path, in meters
%dPsi: heading error from path, in radians
%K: Path curvature at current point along track, in 1/meters 
%s: current distance along path, in meters
%AxDes: The desired acceleration, at the current point along the track, from your
    %speed profile generation code, in meters/(sec2)
%UxDes: The desired velocity at the current point along the track, from
    %your speed profile generation code. In meters/sec
%alphaF: Tire slip at front tire, in rad.
%alphaR: Tire slip at rear tire, in rad
%Ux: Actual longitudinal velocity of car, from GPS, in m/s
%beta: Sideslip of car, from GPS, in rad
%r: Yaw rate, in rad/s, from GPS
%psi: heading angle of car, in rad. 
%posE: East position of car, in meters
%posN: North position of car, in meters
%pathLength: Total path length. 


%Note that you will not be expected to use all of these inputs. If you
%would like access to another signal from the car, let me know. 

function [delta, FxCommand] = controller(e, dPsi, K, s, AxDes, UxDes, alphaF, alphaR, Ux, beta, r, psi, posE, posN, pathLength)
    

    %default code: no feedforward, basically random gains. 
    
    delta = -.05*(e + 10*dPsi);
    FxCommand = 1000*(UxDes - Ux);
    
    
end



    
            


            
            
            
  