function muB = Control(Bfieldnav,pqrdotnav)
    Magtorquer_params
    
    k = 166.67;

    WxB = cross(pqrdotnav,Bfieldnav);
%     muBhat = WxB/norm(WxB);
%     muB = muBnorm*muBhat;

    muB = k*WxB;
    
    if sum(abs(muB)) > 0.2
        muB = (muB/norm(muB))*0.2;
    end
    
end
