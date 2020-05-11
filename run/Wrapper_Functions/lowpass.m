function [d] = lowpassC(signal,delt,n,fcorner)

% lowpass filtering a time series with a n order butterworth filter

% signal   : input time series
% fcorner  : highpass corner frequency
% delt     : sampling interval of data
% n        : order butterworth filter

fnq = 1/(2*delt);   % Nyquist frequency
Wn  = fcorner/fnq;  % butterworth bandpass non-dimensional frequency

[b,a] = butter(n,Wn,'low');      % construct the filter
d = filtfilt(b,a,signal);        % zero phase filter the data

return;
