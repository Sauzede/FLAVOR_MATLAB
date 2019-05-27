

%Example for a fluorescence profile
data=load('profil.dat');
fluo=data(:,1);
depth=data(:,2);
%Latitude and longitude
Lat = -33.968;
Lon = 17.41;
%Day number of the year
DatJ = 45;

%the function FLAVORinput returns the data of inputs for a fluorescence
%profile for ten outputs which are the ten values of chlorophyll for tan
%depths which are the ten depths normalized (0    0.1400    0.2800    0.4200
%0.5600    0.7000  0.8400    0.9800    1.1200    1.2600) with the depth Z0
INPUTS = FLAVORinput(fluo,depth,Lon,Lat,DatJ)
save profil_input.dat INPUTS -ascii

%to have the depths de-normalized :
z0 = ZO_func(fluo,depth);
depth_denormalized = [0:0.14:1.3] .* z0