% Model-3b : Discretized daily water balance model for '2010' daily data
% Considering overflow, but not adding it to outflow

n = size(p);
p10 = p(n-364:end);     % daily precipitation data
q10 = q(n-364:end);     % daily outflow data
ep10 = ep(n-364:end);   % daily PET data

%% Estimating best storage(S_b), residence time(tc) and initial storage for the catchment with Model-3
NSE_vect = [];      % vector to store NSE coefficients     
S_b = 0;            % required storage value
T_c = 0;            % required residence time
St_1 = 0;           % required value of initial storage
max_NSE = 0;        % assumed maximum NSE value

for st_1 = 30:40
    for tc = 20:30
        for sb = 300:400
            outflow = fmodel_3bw(p10, ep10, sb, st_1, tc);   % obtained modelled monthly outflow values for 'sb' storage 
            NSE = fNSE(q10, outflow);                       % NSE coefficient
            NSE_vect = [NSE_vect; NSE];
            if (NSE > max_NSE)
                max_NSE = NSE;
                S_b = sb;
                T_c = tc;
                St_1 = st_1;
            end
        end
    end
end

%% Plotting observed outflow and modelled outflow
outflow = fmodel_3bw(p10, ep10, S_b, St_1, T_c);         % modelled outflow

hold on
plot(q10,'Linewidth',2);
plot(outflow,'Linewidth',2);
xlabel('Days');
ylabel('q (mm/day)');
xlim([1,365]);
title('Daily water balance model');
legend({'Outflow','Modelled outflow'},'Location','northeast');
hold off

