function outflow = fmodel_c1(p, ep, Sc, Su, Ks, Sg, k, a, b, Sct_1, Sut_1, Sgt_1)
    % Function imitates 'Conceptual modelling'
    
    n = length(p);
    outflow = [];       % outflow vector
    % daily water balance model
    for i = 1:n
        % INTERCEPTION
        et = min(Sct_1, ep(i));             % evapotranspiration
        epthr = ep(i) - et;                 % energy transmitted through canopy
        pthr = 0;                           % Throughfall
        Sct_1 = Sct_1 + p(i) - et;
        if(Sct_1 > Sc)
            pthr = Sct_1 - Sc;
            Sct_1 = Sc;
        end
        
        % Mass Balance of Unsaturated Storage
        et2 = epthr * Sut_1 / Su;
        qu = pthr * (Sut_1/Su)^b;
        rec = Ks * (Sut_1/Su)^a;
        Sut_1 = Sut_1 + pthr - qu - et2 - rec;
        q1 = 0;
        if(Sut_1 > Su)
            q1 = Sut_1 - Su;
            Sut_1 = Su;
        end
        
        % RUNOFF ROUTING
        
  
        % BASEFLOW
        bf = k * Sgt_1;
        Sgt_1 = Sgt_1 + rec - bf;
        q2 = 0;
        if(Sgt_1 > Sg)
            q2 = Sgt_1 - Sg;
            Sgt_1 = Sg;
        end
        
        qt = qu + bf;
        outflow = [outflow; qt];
    end
    
end

