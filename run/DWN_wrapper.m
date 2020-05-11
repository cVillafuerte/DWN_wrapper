clear 
close all
clc

% -------------------------------------------------------------------------
%
% Matlab Wrapper to execute DWN
%
% by Carlos Villafuerte, May 2020
%
% -------------------------------------------------------------------------

clc
clear
close all
addpath(genpath('Wrapper_Functions/'))
                   
% -------------------------------------------------------------------------
%%                  Variables for DWN input file
% -------------------------------------------------------------------------

 nfreq       = 2048;          % Number of frequencies (potency of 2)
 tl          = 30;            % Time length of the synthetic seismograms
 seism_opt   = 2;             % Output seismograms (1)disp (2)vel
 dirout      = 'Seismograms'; % Output directory to store seismograms

% -------------------------------------------------------------------------
%%                     Sources coordinates
% ------------------------------------------------------------------------- 

% Source coordinates in m
sx = 0.0;     % East coordinate
sy = 0.0;     % North coordinate
sz = 10000;   % Depth coordinate
 
% -------------------------------------------------------------------------
%%                     Source Parameters
% ------------------------------------------------------------------------- 
 
Mo        = 3.4992e16;   % Source Moment in N m
strike    = 270;         % Strike
dip       = 40;          % Dip
rake      = 90;          % Rake

source_opt  = 2;      % Source time function option. 
                      % (1) Smooth ramp function
                      % (2) Ramp (box-car slip rate) 
                      % (3) Gaussian function
                      
riseT   = 0.2;      % Characteristic time parameter for the slip rate function 
                    %(rise-time, pseudoperiod, etc)
 
tshift  = 0.0;      % Time shift (s) 

% -------------------------------------------------------------------------
%%                  1D Velocity model
% ------------------------------------------------------------------------- 
 
% In this section one can create a 1D layered velocity model (nlayers,6)
% or read it from a .txt or a .mat file with the following order:

% Thickness H, Vp, Vs, rho, Qp,Qs

load('vel_model.txt')

H   = vel_model(:,1); % H is the thickness of every layer (in m)                        
Vp  = vel_model(:,2); % Vp in m/s
Vs  = vel_model(:,3); % Vs in m/s
rho = vel_model(:,4); % rho in kg/m3
Qp  = vel_model(:,5); % Qp
Qs  = vel_model(:,6); % Qs

nlay = length(Vp);          % Number of layers

% -------------------------------------------------------------------------
%%                        Stations coordinates
% ------------------------------------------------------------------------- 
 
% In this section one can specify the coordinates of the stations on the surface
% or read them from a .txt or a .mat file. 

% If are read them from a file, file should have 2 columns:
% East coordinate, North coordinate

stats = load('input_stats.txt');

nstats = length(stats(:,1));     % Number of receivers

% -------------------------------------------------------------------------
%%                  Creating files for axitra
% -------------------------------------------------------------------------
 
% Creating DWN_point_source.in file
make_DWN_inputs

% -------------------------------------------------------------------------
%%                Computing synthetic seismograms
% -------------------------------------------------------------------------

system('../bin/DWN_point_source > screen_DWN.txt');

system('rm DWN_point_source.in stations.in source_spectrum.out');

