%This is the test harness for the ME227 Project
%Nitin Kapania, 4/2015

%%

%add other paths and clear workspace
clear all; close all; clc;
addpath(genpath('common'));

%get vehicle and the path to drive
veh = getVehicle(); %just loads the TTS parameters. No other options for this.
path = genWorldFromCSV('PS5.csv'); 

%% To Do: Generate your own Velocity and Acceleration Profile.
speedProfile = generateSpeedTrajectory(path, veh);

%% Simulate your controller's response
simData = bikeSim(path, veh, speedProfile);

%% Visualize the results
animateSimResults(simData, path, veh);
