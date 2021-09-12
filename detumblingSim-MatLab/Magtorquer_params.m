n = 250;                    %%No of turns
rodRadius = 5e-3;           %%torquer rod
muR = 1453;                 %%steel core
length = 80e-3;
A = pi*(rodRadius^2);       %%Area of cs
RperLength = 0.3386;         
Rnet = RperLength*2*pi*rodRadius*n;     %%Net R
rsltn = 255;            %%Arduino resolution 256
voltAvail = (-5:(5/rsltn):5)';

% demagnetisation fctr
Nd = (4*(log(length/rodRadius) - 1))/(((length^2)/(rodRadius^2))-(4*log(length/rodRadius)));

tempVar = 1 + ((muR - 1)/(1 + (Nd*(muR - 1))));
muBnorm = 0.2;              %%Mag moment  0.2Am2
