clc
clear
% Extraction of data
% converting dates from char array to datetime format
% checking for missing data
% conerting PET dates from "MM-YYYY" to "DD-MM-YYYY" format
%
%% Rainfall and flow data
pqData = importdata('2_periyar_neeliswaram.xlsx');
pq = pqData.data;   % Extracting 
n = length(pq);
p = pq(1:n-2,1);    % Rainfall (mm/day)
q = pq(1:n-2,3);    % Flow (mm/day)

%%

date1 = cell2mat(pqDates3(1:end,1));
p_date = datetime(date1);   % Dates for rainfall
date2 = cell2mat(pqDates3(1:end,3));
q_date = datetime(date2);   % Dates for flow

%% Checking missing data for rainfall and flow
mdate = p_date(1,1);
for i = 2:n-2
    if((p_date(i,1) == p_date(i-1,1)+1))
        mdate = [mdate;p_date(i,1)];
    end
end

%% Potential Evapotranspiration data
epData = importdata('F:\CE610A\Project\2_perriyar_PET_average.xlsx');
ep = epData.data;           % Average Potential Evapotranspiration (monthly)
date3 = cell2mat(pet(1:end,1));
%ep_date = datetime(date3);   % Dates for flow
%%
%date3 = cell2mat(epDates(2:361,1)); % dates in "MM-YYYY" format
ndate3 = "";     % vector to store dates in "DD-MM-YYYY" format
for i = 1:360
   ndate3 = [ndate3; "01" + date3(i,5:7)+ "-" + date3(i,1:4)];  % converted date to "DD-MM-YYYY"
end

char_date = convertStringsToChars(ndate3(2:361,1)); % converted string dates to char array

mat_date = cell2mat(char_date);                     % converted char array cells to matrix
%%
ep_date = datetime(mat_date);                       % converted to Dates for PET

