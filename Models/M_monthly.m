% Model-2 : Discretized monthly water balance model

%% Estimating best storage(S_b) value for catchment with Model-2a
NSE_vect1 = [];      % vector to store NSE coefficients     
S_b1 = 0;            % required storage value
max_NSE1 = 0;        % assumed maximum NSE value
for sb = 1:200
    % modelled monthly outflow values for 'sb' storage
    outflow1 = fmodel_2(avgm_p, avgm_ep, sb, 1);
    NSE = fNSE(avgm_q, outflow1);                    % NSE coefficient
    NSE_vect1 = [NSE_vect1; NSE];
    if (NSE > max_NSE1)
        max_NSE1 = NSE;
        S_b1 = sb;
    end
end
%% Plotting variation of NSE w.r.t catchment storage(S_b)
hold on
plot([1:200],NSE_vect1, 'Linewidth',2);
xlabel('Catchment storage (S_b) (in mm)');
ylabel('NSE');
title('NSE coefficient vs catchment storage');
hold off
%% Plotting observed outflow and modelled outflow
outflow1 = fmodel_2(avgm_p, avgm_ep, S_b1, 1);      % modelled outflow

hold on
plot(avgm_q,'Linewidth',2);
plot(outflow1,'Linewidth',2);
xlabel('Month');
ylabel('q (mm/month)');
xlim([1,12]);
title('Monthly water balance model');
legend({'Outflow','Modelled outflow'},'Location','northeast');
hold off

%% Estimating best storage(S_b) value for catchment with Model-2b
NSE_vect2 = [];      % vector to store NSE coefficients     
S_b2 = 0;            % required storage value
max_NSE2 = 0;        % assumed maximum NSE value
for sb = 1:200
    % modelled monthly outflow values for 'sb' storage
    outflow2 = fmodel_2(avgm_p, avgm_ep, sb, 2);
    NSE = fNSE(avgm_q, outflow2);                    % NSE coefficient
    NSE_vect2 = [NSE_vect2; NSE];
    if (NSE > max_NSE2)
        max_NSE2 = NSE;
        S_b2 = sb;
    end
end
%% Plotting variation of NSE w.r.t catchment storage(S_b)
hold on
plot([1:200],NSE_vect2, 'Linewidth',2);
xlabel('Catchment storage (S_b) (in mm)');
ylabel('NSE');
title('NSE coefficient vs catchment storage');
hold off
%% Plotting observed outflow and modelled outflow
outflow2 = fmodel_2(avgm_p, avgm_ep, S_b2, 2);      % modelled outflow

hold on
plot(avgm_q,'Linewidth',2);
plot(outflow2,'Linewidth',2);
xlabel('Month');
ylabel('Q_o (mm/month)');
xlim([1,12]);
title('Discretized monthly water balance model-b (catchment storage as 152mm)');
legend({'Outflow','Modelled outflow'},'Location','northeast');
hold off


