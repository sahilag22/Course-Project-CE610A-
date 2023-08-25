function outflow = fmodel_2(avg_p, avg_ep, Sb, type)
    % Function imitates 'Discretized monthly water balance model'
    
    n = length(avg_p);
    outflow = [];       % outflow vector
    St_1 = Sb;
    
    % monthly water balance model
    if type == 1
        for i = 1:n
            et = avg_ep(i) * St_1/Sb;               % evapotranspiration
            S_temp = St_1 + avg_p(i) - et;
            qt = 0;
            if(S_temp > Sb)
               qt = S_temp - Sb; 
            end
            outflow = [outflow; qt];
            St_1 = St_1 + avg_p(i) - et - qt;
        end
    end
    
    if type == 2 
        for i = 1:n
            et = min(avg_ep(i)*St_1/Sb, St_1);      % evapotranspiration
            S_temp = St_1 + avg_p(i) - et;
            qt = 0;
            if(S_temp > Sb)
               qt = S_temp - Sb; 
            end
            outflow = [outflow; qt];
            St_1 = St_1 + avg_p(i) - et - qt;
        end
    end    
    
end

