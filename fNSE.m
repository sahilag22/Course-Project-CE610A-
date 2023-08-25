function NSE = fNSE(obs, sim)
    % obs : observed data
    % sim : simulated data
    % NSE : Nash Sutcliffe model Efficiency coefficient
    sq1 = sum((obs - sim).^2);
    sq2 = sum((obs - mean(obs)).^2);
    NSE = 1 - sq1/sq2;
end

