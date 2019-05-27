function [res] = FiltreMediane(y,m)
ny = length(y);
res = nan(1,ny);
for i =1:ny
    indi = (i-m):(i+m);
    if (i<=m)
        indi = 1:(i+m);
    end
    if (i+m>ny)
        indi = i:ny;
    end
    tmpi = y(indi);
    res(i) = nanmedian(tmpi);
end
end