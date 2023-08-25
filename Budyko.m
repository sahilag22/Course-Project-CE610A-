% Plotting data
%
%% Budyko's curve and envelope
x = 0:0.01:10;
y = 1 - exp(-x);

avg_P = sum(avg_p);     % Average annual rainfall
avg_Q = sum(avg_q);     % Average annual outflow
avg_E = avg_P - avg_Q;  % Average annual evapotranspiration
avg_Ep = sum(avg_ep);   % Average annual PET
E_P = avg_E/avg_P;
Ep_P = avg_Ep/avg_P;

hold on
plot(x,y,'LineWidth',2);
scatter(Ep_P,E_P,'filled');
plot(x,x,'-.b','LineWidth',1);

title("Plot");
xlabel('${\it} E_p/P $','Interpreter','Latex');
ylabel('${\it} E/P $','Interpreter','Latex');
ylim([0 1.25]);
xlim([0 5]);
hold off

yl = yline(1,'--','y = 1');
yl.LabelHorizontalAlignment = 'left';
% yl2 = yline(x,'--','k');
legend({"Budyko's curve",'Periyar catchment','y = x'},...
    'Location','northeast','NumColumns',2);


