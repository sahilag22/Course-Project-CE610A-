% Model-c1 : Discretized daily water balance model for '2010' daily data

n = size(p);
p10 = p(n-364:end);     % daily precipitation data
q10 = q(n-364:end);     % daily outflow data
ep10 = ep(n-364:end);   % daily PET data

%% Estimating best parameters for the catchment with Model-c1
Sc = 1;             % required canopy storage capacity
Su = 1;             % required unsaturated storage capacity
Sg = 1;             % required ground water storage capacity
Ks = 100;
K = 0.3;
Sct_1 = 1;          % required value of initial canopy storage
Sut_1 = 2;          % required value of initial unsaturated storage
Sgt_1 = 2;          % required value of initial groundwater storage
alpha = 1;          % aplha
beta = 1;           % beta

NSE_vect = [];      % vector to store NSE coefficients
max_NSE = 0;        % assumed maximum NSE value

for a = 1.5:0.1:2
for b = 2.5:0.1:3

for k = 1:0.1:1.2
    for ks = 35:40
        for sg = 10:15
            for su = 600:610
                % obtained modelled monthly outflow values for 'sb' storage 
                outflow = fmodel_c1(p10, ep10, Sc, su, ks, sg, k, a, b, Sct_1, Sut_1, Sgt_1);
                NSE = fNSE(q10, outflow);       % NSE coefficient
                NSE_vect = [NSE_vect; NSE];
                if (NSE > max_NSE)
                    max_NSE = NSE;
                    Su = su;
                    Sg = sg;
                    Ks = ks;
                    K = k;
                    alpha = a;
                    beta = b;
                end
            end
        end
    end
end

end
end

%% Plotting observed outflow and modelled outflow
% modelled outflow
outflow = fmodel_c1(p10, ep10, Sc, Su, Ks, Sg, K, alpha, beta, Sct_1, Sut_1, Sgt_1);
hold on
plot(q10,'Linewidth',2);
plot(outflow,'Linewidth',2);
xlabel('Days');
ylabel('q (mm/day)');
xlim([1,365]); 
title('Conceptual water balance model');
legend({'Outflow','Modelled outflow'},'Location','northeast');
hold off

