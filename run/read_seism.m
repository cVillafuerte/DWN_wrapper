clc
clear
close all

% Fast plotting of synthetic seismograms

fc = 5.0;    % Corner frequency for low-pass filter
nl = 2048;   % Number of time samples
tl = 30;     % Seismogram time length

nstats = 20;              % Number of stations
dirseism = 'Seismograms'; % Directory of seismograms outputs

dt = tl/nl;         %time step
t = 0:dt:dt*(nl-1); % time vector


for istat = 1:nstats
       
Xtmp = load([dirseism,'/seism_',num2str(istat),'_E.txt']);
Ytmp = load([dirseism,'/seism_',num2str(istat),'_N.txt']);
Ztmp = load([dirseism,'/seism_',num2str(istat),'_Z.txt']);


X = lowpass(Xtmp,dt,3,fc);
Y = lowpass(Ytmp,dt,3,fc);
Z = lowpass(Ztmp,dt,3,fc);

figure(istat)
subplot(3,1,1)
plot(t,X,'linewidth',1); hold on
xlim([0,10])
title({['Station ',num2str(istat)],'East'})

subplot(3,1,2)
plot(t,Y,'linewidth',1); hold on
xlim([0,10])
title('North')

subplot(3,1,3)
plot(t,Z,'linewidth',1); hold on
xlim([0,10])
title('Up-Down')
xlabel('Time (s)')

end


