events = Cajal_data.evnt.scalars.EVNT.data;
ts = 1000*Cajal_data.evnt.scalars.EVNT.ts;

FID = fopen('out.csv','w');

[nrows,ncols] = size(events);
for row = 1:ncols 
    Save = [events(row); ts(row)];
    fprintf(FID, '%d, %3.4f', Save);
    fprintf(FID,'\n');
end
fclose(FID);
