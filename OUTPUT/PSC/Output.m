

%Example for ten points retrieved by the MLP for each phytoplankton size classes (micro,nano and picophytoplankton -> MICRO_mlp, NANO_mlp and PICO_mlp) from a fluorescence profile (fluo)
%The outputs after the second step are three quasi-continuous profiles (same resolution as the initial fluorescence profile) of total chlorophyll-a concentrations associated with the three phytoplankton size classes retrieved with the FLAVOR method (MICRO_cal, NANO_cal and PICO_cal)

%the fluorescence profile is loaded
data=load('profil.dat');
fluo=data(:,1);
depth=data(:,2);

%The ten points retrieved by the MLP are loaded
MICRO_mlp = load('MICRO_mlp.dat');
NANO_mlp = load('NANO_mlp.dat');
PICO_mlp = load('PICO_mlp.dat');

Z0= ZO_func(fluo,depth);
%To retrieve a quasi-continuous profile, the points are interpolated
%linearly
depth_MLP = [0:0.14:1.3] .* Z0;
MICRO_cal = interp1([depth_MLP 1.5*Z0 nanmax(depth)],[MICRO_mlp' 0 0],depth,'linear');
NANO_cal = interp1([depth_MLP 1.5*Z0 nanmax(depth)],[NANO_mlp' 0 0],depth,'linear');
PICO_cal = interp1([depth_MLP 1.5*Z0 nanmax(depth)],[PICO_mlp' 0 0],depth,'linear');
