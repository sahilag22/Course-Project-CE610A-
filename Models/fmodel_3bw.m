function outflow = fmodel_3bw(avg_p, avg_ep, Sb, St_1, tc)
    % Function imitates 'Discretized daily water balance model'
    
    n = length(avg_p);
    outflow = [];       % outflow vector
    
    % daily water balance model
    for i = 1:n
        et = avg_ep(i) * St_1/Sb;               % evapotranspiration
        qt = St_1/tc;                           % outflow
        S_temp = St_1 + avg_p(i) - et - qt;
        if(S_temp > Sb)
            St_1 = Sb;
        else
            St_1 = S_temp;
        end
        outflow = [outflow; qt];
    end
    
end

