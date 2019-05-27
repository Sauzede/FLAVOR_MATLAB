function[input_final]= FLAVORinput(fluo,depth,lon,lat,datJ)
%Computing of the Z0 depth
z0 = ZO_func(fluo,depth);

%Normalization of teh depth
NP = depth/z0;
%normalization of the fluorescence values
fluo_norm = (fluo-nanmin(fluo))/(nanmax(fluo)-nanmin(fluo));
c = interp1(NP,fluo_norm,0:0.14:1.3,'linear','extrap');

lon_rad=RadLon(lon);
dat_rad=RadDat(datJ);
Lat_in=lat/90;

%inputs of the MLP
input = [z0 c sin(dat_rad) cos(dat_rad) sin(lon_rad) cos(lon_rad) Lat_in];
%Finally, we put the depth at which the chlorophyll is computed
depth_NP = 0:0.14:1.3;
input_final=zeros(length(0:0.14:1.3),length(input)+1);
for i = 1:length(0:0.14:1.3);
    input_final(i,:)=[input depth_NP(i)];
end

end