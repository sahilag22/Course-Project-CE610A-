% Manipulation of data
%
%% Converting monthly to daily PET data for 30 years
ep = [];
for i = 0:29
    ep = [ep; ones(31,1)*epm(i*12+1,1)];    % January
    ep = [ep; ones(28,1)*epm(i*12+2,1)];    % February
    ep = [ep; ones(31,1)*epm(i*12+3,1)];    % March
    ep = [ep; ones(30,1)*epm(i*12+4,1)];    % April
    ep = [ep; ones(31,1)*epm(i*12+5,1)];    % May
    ep = [ep; ones(30,1)*epm(i*12+6,1)];    % June
    ep = [ep; ones(31,1)*epm(i*12+7,1)];    % July
    ep = [ep; ones(31,1)*epm(i*12+8,1)];    % August
    ep = [ep; ones(30,1)*epm(i*12+9,1)];    % Septemper
    ep = [ep; ones(31,1)*epm(i*12+10,1)];   % October
    ep = [ep; ones(30,1)*epm(i*12+11,1)];   % November
    ep = [ep; ones(31,1)*epm(i*12+12,1)];   % December
end

%% Removing "29-Feb" data from 30 years data
% vector to indicate position of "29-Feb" data
Feb29 = (month(pn_date) == 2) & (day(pn_date) == 29);
p_date = pn_date;               % dates for averaged daily rainfall and outflow
p_date(Feb29) = [];             % dates with no "29-Feb" date

%Removing "29-Feb" data from rainfall data
p = pn;
p(Feb29) = [];                  % modified rainfall daily data for 30 years

%Removing "29-Feb" data from outflow data
q = qn;
q(Feb29) = [];                  % modified outflow daily data for 30 years

%% Daily average data of 30 years
n_p = reshape(p,[365,30]);      % change in dimensions to [365,30]
avg_p = mean(n_p,2);            % averaged daily rainfall [365,1]

n_ep = reshape(ep,[365,30]);    % change in dimensions to [365,30]
avg_ep = mean(n_ep,2);          % averaged daily PET [365,1]

n_q = reshape(q,[365,30]);      % change in dimensions to [365,30]
avg_q = mean(n_q,2);            % averaged daily outflow [365,1]

%% Monthly average data
% Potential Evapotranspiration(PET) data
n_ep = reshape(epm,[12,30]);    % changing dimensions to [12,30]
avgm_ep = mean(n_ep,2);         % averaged monthly PET [12,1]

% Converting daily data to monthly data for Precipitation
tt_p = timetable(p_date(1:365),avg_p);
avgtt_p = retime(tt_p,'Monthly','mean');
avgm_p = avgtt_p{:,1};          % averaged monthly rainfall [12,1]

% Converting daily data to monthly data for Outflow
tt_q = timetable(p_date(1:365),avg_q);
avgtt_q = retime(tt_q,'Monthly','mean');
avgm_q = avgtt_q{:,1};          % averaged monthly outflow [12,1]

%% Plotting regime curves
months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",...
          "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
hold on
plot(0:11,avgm_p,'Linewidth',2);
plot(0:11,avgm_ep,'Linewidth',2);
plot(0:11,avgm_q,'Linewidth',2);
title('Regime curves');
xlabel('Month');
xticks(0:11);
xticklabels(months);
xlim([0,11]);
ylabel('Water balance components (mm/month)');
hold off
legend({'Precipitation','PET','Outflow'},'Location','northeast');

%% PDC and FDC
avgo_p = sort(avg_p,'descend');
avgo_q = sort(avg_q,'descend');

rank_p = [1];
rank_q = [1];
for i = 2:365
    if avgo_p(i-1) == avgo_p(i)
        rank_p = [rank_p; rank_p(i-1)];
    else
        rank_p = [rank_p; i];
    end
    
    if avgo_q(i-1) == avgo_q(i)
        rank_q = [rank_q; rank_q(i-1)];
    else
        rank_q = [rank_q; i];
    end
end

plot(rank_p/365,avgo_p,'Linewidth',2);
hold on
plot(rank_q/365,avgo_q,'Linewidth',2);
xlabel('Probability of exceedance (n/N)');
ylabel('p\q (mm/day)');
legend({'PDC','FDC'},'Location','northeast');
hold off

