

%Example for ten points retrieved by the MLP (CHL_mlp) from a fluorescence profile (fluo)
%The output after the second step is a quasi-continuous profile (same resolution as the initial flmuorescence profile) of total chlorophyll-a concentration retrieved with the FLAVOR method (CHL_cal)

%the fluorescence profile is loaded
data=load('profil.dat');
fluo=data(:,1);
depth=data(:,2);

CHL_mlp = load('CHL_mlp.dat');
Z0 = ZO_func(fluo,depth);

output = FLAVOR_CHL_step2(CHL_mlp,Z0,fluo,depth);
CHL_cal = output;
plot(CHL_cal,-depth);