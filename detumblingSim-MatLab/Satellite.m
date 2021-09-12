function derivative = Satellite(t,state)

global BB invI I Bfieldmeasured pqrdotmeasured trgt
global Bfieldnav pqrdotnav current voltage muB

%%Earth and sat params
Earth
Inertia

x = state(1);
y = state(2);
z = state(3);

q0123 = state(7:10);
pdot = state(11);
qdot = state(12);
rdot = state(13);
pqrdot = state(11:13);

%%translation
vel = state(4:6);
r = state(1:3);
rho = norm(r);
rhat = r/rho;
Fgrav = -(G*M*m/rho^2)*rhat;
acc = Fgrav/m;

%%Mag stuff
BI = [0;0;0];
BI(1) = 0.008;
BB = TIBquat(q0123)'*BI;

deed = 1;
if (pqrdot(3) < 0.0003) & (deed == 1)
    trgt = 1;
    deed = 0;
end

%%Bfield and ang velocty measured from snsr
[Bfieldmeasured,pqrdotmeasured] = Sensor(BB,pqrdot);

%%Navigation Block (correction)
[Bfieldnav,pqrdotnav] = Navigation(Bfieldmeasured,pqrdotmeasured);


%%CONTROL BLOCK
muB = Control(Bfieldnav,pqrdotnav);
Magtorquer_params
current = muB/(n*A*tempVar);
voltage = current*Rnet;
cmprsn = zeros(length(voltAvail),3);
for z = 1:length(voltAvail)
    cmprsn(z,1) = voltAvail(z,1) - voltage(1);
    cmprsn(z,2) = voltAvail(z,1) - voltage(2);
    cmprsn(z,3) = voltAvail(z,1) - voltage(3);
end
[indexVal1,index1] = min(abs(cmprsn(1:length(voltAvail),1)));
[indexVal2,index2] = min(abs(cmprsn(1:length(voltAvail),2)));
[indexVal3,index3] = min(abs(cmprsn(1:length(voltAvail),3)));

voltage(1) = voltAvail(index1);
voltage(2) = voltAvail(index2);
voltage(3) = voltAvail(index3);
current = voltage/Rnet;
muB = current*n*A*tempVar;

LMN_magtorquers = cross(muB,BB);

%%%Rotational Dynamics
PQRMAT = [0 -pdot -qdot -rdot;pdot 0 rdot -qdot;qdot -rdot 0 pdot;rdot qdot -pdot 0];
q0123dot = 0.5*PQRMAT*q0123;
H = I*pqrdot;
pqrddot = invI*(LMN_magtorquers - cross(pqrdot,H));

derivative = [vel;acc;q0123dot;pqrddot];

