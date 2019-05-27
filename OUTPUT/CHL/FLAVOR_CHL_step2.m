%Function of the second step of the FLAVOR method : retrieval of a quasi continuous profile of total chlorophyll-a from the ten points predicted by the MLP

function[fluo_calib] = FLAVOR_CHL_step2(chlo,z0,fluo,depth)

	fluoo(:,1) = depth;
	fluoo(:,2) = fluo;
	hplcc(:,1) = [0:0.14:1.3] .* z0;
	hplcc(:,2) = chlo;

	hplc.interp = InterpWithProfile(hplcc, fluoo);

	Depth = 0.1 .* [nanmax(depth(isnan(fluo)==0))];

	depth_fin = find(depth(isnan(fluo)==0)> (nanmax(depth(isnan(fluo)==0))-Depth));

	fluo_corr = fluo-nanmean(fluo(depth_fin));

    Int1 = interp1(hplc.interp(:,1),hplc.interp(:,2),[1:1:z0],'linear','extrap');
    Int1 = inpaint_nans(Int1);
    Int2 = interp1(depth,fluo_corr,[1:1:z0],'linear','extrap');
    Int2 = inpaint_nans(Int2);
	alpha = sum(Int1)/sum(Int2);

	fluo_calib = [fluo_corr] .* alpha;
end
