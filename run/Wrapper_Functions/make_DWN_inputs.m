% Script to create the DWN inputs

% Write DWN input file
fid1 = fopen('DWN_point_source.in', 'wt');
fprintf(fid1,'%s                 ! Seismograms output directory\n',dirout);
fprintf(fid1,'%d                 ! Number of layers\n',nlay);
fprintf(fid1,'%f                 ! Point source depth (km)\n',sz/1e3);
fprintf(fid1,'%4.2f %4.2f %4.2f  ! Strike, Dip, Rake (deg)\n',strike,dip,rake);
fprintf(fid1,'%d                 ! Number of stations\n',nstats);
fprintf(fid1,'%d %d              ! Number of samples, window duration (s)\n',nfreq,tl);
fprintf(fid1,'%4.8e              ! Seismic moment (Nw*m)\n',Mo);
fprintf(fid1,'%d                 ! Source time function option\n',source_opt);
fprintf(fid1,'%f                 ! Rise time (gaussian)\n',riseT);
fprintf(fid1,'%f                 ! Source origin time (center gaussian)\n',tshift);
fprintf(fid1,'%d                 ! Output Seismogram option (1)disp (2)vel\n',seism_opt);
for ilay = 1:nlay
    fprintf(fid1,'%4.2f %4.2f %4.2f %4.2f %4.2f %4.2f   \n',H(ilay)/1e3,Vp(ilay)/1e3,Vs(ilay)/1e3,rho(ilay)/1e3,Qp(ilay),Qs(ilay));
end
fclose(fid1);

% Write DWN stations input file
fid1 = fopen('stations.in', 'wt');
for istat = 1:nstats
    fprintf(fid1,'%5.5f %5.5f\n',(stats(istat,2)-sy)/1e3,(stats(istat,1)-sx)/1e3);
end
fclose(fid1);
