% Model-3 : Discretized daily water balance model for daily averaged data
% Assuming catchment is fully saturated initially

%% Estimating best storage(S_b) and residence time(tc) for the catchment with Model-3
NSE_vect = [];      % vector to store NSE coefficients     
S_b = 0;            % required storage value
T_c = 0;            % required residence time
max_NSE = 0;        % assumed maximum NSE value

for tc = 1:30
    for sb = 101:150
        outflow = fmodel_3a(avg_p, avg_ep, sb, sb, tc);     % obtained modelled monthly outflow values for 'sb' storage 
        NSE = fNSE(avg_q, outflow);                    % NSE coefficient
        NSE_vect = [NSE_vect; NSE];
        if (NSE > max_NSE)
            max_NSE = NSE;
            S_b = sb;
            T_c = tc;
        end
    end
end

%% Plotting NSE values w.r.t Catchment storage(S_b) and residence time(tc)
NSE_mat = reshape(NSE_vect,[200,100]);
sb = 1:200;
tc = 1:100;
[X,Y] = meshgrid(tc,sb);
surf(X,Y,NSE_mat)
hold on
xlabel('Residence time (t_c) (in sec)');
ylabel('Catchment storage (S_b) (in mm)');
zlabel('NSE');
title('NSE coefficient vs (catchment storage and residence time)');
hold off

%% Plotting observed outflow and modelled outflow
outflow = fmodel_3a(avg_p, avg_ep, S_b, S_b, T_c);      % modelled outflow

hold on
plot(avg_q,'Linewidth',2);
plot(outflow,'Linewidth',2);
xlabel('Days');
ylabel('q (mm/day)');
xlim([1,365]);
title('Daily water balance model');
legend({'Outflow','Modelled outflow'},'Location','northeast');
hold off

