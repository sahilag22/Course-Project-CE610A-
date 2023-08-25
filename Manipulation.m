% Manipulation of data
%
%% Averaging 30 years data
% Potential Evapotranspiration(PET) data
n_ep = reshape(ep,[12,30]);     % changing dimensions to [12,30]
avgm_ep = mean(n_ep,2);         % averaged monthly PET [12,1]
datem_ep = ep_date(349:360,1);  % dates for averaged PET

% Converting monthly to daily PET
avg_ep = [];
avg_ep = [avg_ep; ones(31,1)*avgm_ep(1,1)];    % January
avg_ep = [avg_ep; ones(28,1)*avgm_ep(2,1)];    % February
avg_ep = [avg_ep; ones(31,1)*avgm_ep(3,1)];    % March
avg_ep = [avg_ep; ones(30,1)*avgm_ep(4,1)];    % April
avg_ep = [avg_ep; ones(31,1)*avgm_ep(5,1)];    % May
avg_ep = [avg_ep; ones(30,1)*avgm_ep(6,1)];    % June
avg_ep = [avg_ep; ones(31,1)*avgm_ep(7,1)];    % July
avg_ep = [avg_ep; ones(31,1)*avgm_ep(8,1)];    % August
avg_ep = [avg_ep; ones(30,1)*avgm_ep(9,1)];    % Septemper
avg_ep = [avg_ep; ones(31,1)*avgm_ep(10,1)];   % October
avg_ep = [avg_ep; ones(30,1)*avgm_ep(11,1)];   % November
avg_ep = [avg_ep; ones(31,1)*avgm_ep(12,1)];   % December

% vector to indicate position of "29-Feb" data
Feb29 = (month(p_date) == 2) & (day(p_date) == 29);
date_pq = p_date;               % dates for averaged daily rainfall and outflow
date_pq(Feb29) = [];            % dates with no "29-Feb" date
date_y = date_pq(10586:10950);  % dates in a year

% Rainfall data
n_p = p;                        % variable to store rainfall
%Removed "29-Feb" data from rainfall data
n_p(Feb29) = [];
n_p = reshape(n_p,[365,30]);    % change in dimensions to [365,30]
avg_p = mean(n_p,2);            % averaged daily rainfall [365,1]

% Outflow data
n_q = q;                        % variable to store outflow
%Removed "29-Feb" data from outflow data
n_q(Feb29) = [];
n_q = reshape(n_q,[365,30]);    % change in dimensions to [365,30]
avg_q = mean(n_q,2);            % averaged daily outflow [365,1]

%%
% Converting daily data to monthly data for Precipitation
tt_p = timetable(date_y,avg_p);
avgtt_p = retime(tt_p,'Monthly','mean');
avgm_p = avgtt_p{:,1};

% Converting daily data to monthly data for Outflow
tt_q = timetable(date_y,avg_q);
avgtt_q = retime(tt_q,'Monthly','mean');
avgm_q = avgtt_q{:,1};

%% Plotting regime curves
hold on
plot(avgtt_p.date_y, avgtt_p{:,1},'Linewidth',2);
plot(datem_ep,avgm_ep,'Linewidth',2);
plot(avgtt_q.date_y, avgtt_q{:,1},'Linewidth',2);
title('Regime curves');
xlabel('Month');
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
ylabel('Q_o or P_o (mm/day)');
legend({'PDC','FDC'},'Location','northeast');
hold off


