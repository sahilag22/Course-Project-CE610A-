% Extraction of data
% converting dates from char array to datetime format
% checking for missing data
% conerting PET dates from "MM-YYYY" to "DD-MM-YYYY" format
%
%% Rainfall and flow data
pqData = importdata('F:\CE610A\Project\2_periyar_neeliswaram.xlsx');
pq = pqData.data;       % Extracting 
n = length(pq);
pn = pq(1:n-2,1);       % Rainfall (mm/day)
qn = pq(1:n-2,3);       % Flow (mm/day)

pqDates = pqData.textdata;
date1 = cell2mat(pqDates(2:end,1));
date2 = cell2mat(pqDates(2:end,3));
pn_date = datetime(date1);   % Dates for rainfall
qn_date = datetime(date2);   % Dates for flow

%% Potential Evapotranspiration data
epData = importdata('F:\CE610A\Project\2_perriyar_PET_average.xlsx');
epm = epData.data; 

%% Checking missing data for rainfall and flow
mdate = pn_date(1,1);
for i = 2:n-2
    if((pn_date(i,1) == pn_date(i-1,1)+1))
        mdate = [mdate;pn_date(i,1)];
    end
end
