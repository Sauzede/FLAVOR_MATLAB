function[z0] = ZO_func(fluo,depth)

fluo_med = FiltreMediane(fluo,10);

fluo2 = fluo_med(length(fluo_med)-10 : length(fluo_med));
fluo_end = nanmean(fluo2);
fluo3 = fluo_med - fluo_end;

depth2 = depth(fluo3>0);
fluo3 = fluo3(fluo3>0);

fluo_norm = (fluo3-nanmin(fluo3))/(nanmax(fluo3)-nanmin(fluo3));
fluo_norm = roundn(fluo_norm,-1);

depth2=depth2'

D=find(fluo_norm==0 & depth2>depth2(find(fluo_norm==nanmax(fluo_norm),1)),1);
z0 = depth2(D);
end