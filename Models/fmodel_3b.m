function outflow = fmodel_3b(avg_p, avg_ep, Sb, St_1, tc)
    % Function imitates 'Discretized daily water balance model'
    
    n = length(avg_p);
    outflow = [];       % outflow vector
    
    % daily water balance model
    for i = 1:n
        et = avg_ep(i) * St_1/Sb;               % evapotranspiration
        qt = St_1/tc;                           % outflow
        S_temp = St_1 + avg_p(i) - et - qt;
        if(S_temp > Sb)
            qt = qt + S_temp - Sb;
        end
        outflow = [outflow; qt];
        St_1 = St_1 + avg_p(i) - et - qt;
    end
    
end

