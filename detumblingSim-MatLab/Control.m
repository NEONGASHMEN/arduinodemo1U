function muB = Control(Bfieldnav,pqrdotnav)
    Magtorquer_params
    
%     k = 67200;          %%Calculated by assuming current = 40milliamps
    k = 166.67;
%     current = k*cross(pqrdotnav,Bfieldnav)/(n*A);
    WxB = cross(pqrdotnav,Bfieldnav);
%     muBhat = WxB/norm(WxB);
%     muB = muBnorm*muBhat;

    muB = k*WxB;
    
    if sum(abs(muB)) > 0.2
        muB = (muB/norm(muB))*0.2;
    end

%     if lt > 200
%         muB = muB/4;
%     end
    %%If magnetic saturation takes place at 40 milli amps
%     if sum(abs(current)) > 0.04             
%         current = (current/norm(current))*0.04;
%     end
end
