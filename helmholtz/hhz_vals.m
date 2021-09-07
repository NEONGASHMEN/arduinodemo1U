
clear
clc
close all
 
%%To calculate the magnetic field at the centre of a helmholtz coil
 
%fid = fopen('data.txt', 'w');
%fprintf(fid,'%4s\t\t %4s\t\t %4s\t\t %4s\t\t  %4s\t\t', 'Current', 'No of turns', 'Length of wire', 'Resistance', 'Power' );                %  X-axis common time
 
%Formula B = [0.8991*(10)^(-6)*(n*I)]/R
 
%mu = 12.56e-7;
k = 0.8991e-6;      
r = 0.15;           %radius of coil in metre
B = 0.008;          %magnetic field in gauss
 
rho = 1.68e-8;      %resistivity of copper
A_wire = 2.62e-6;   %area of 13 gauge wire
n = 0;
j=1;

areaArray = [10.6 8.36 6.63 5.26 4.17 3.31 2.63 2.08 1.65 1.31 1.04 0.82 0.65 0.52];
guageArray = 7:20;
wires = cell(5,length(areaArray));


for z = 1:length(areaArray)
    
    A_wire = areaArray(z)*1e-6;
    
    for i=1:0.1:15   
      I(j)=i;                            %current
      n(j) = (B*r)/(k*I(j));             %number of turns    

      L_wire(j) = 2*pi*r*n(j);
      R(j) = (rho*L_wire(j))/(A_wire);       %resistance of wire

      P(j) = I(j)*I(j)*R(j);                 %Power required

      %fprintf(fid,'\n %4.4f \t\t %4.4f \t\t %4.4f \t\t %4.4f \t\t %4.4f\t\t', I(j), n(j), L_wire(j), R(j), P(j));      
      
      
      j=j+1;
      if j > 141
          j = 1;
      end
    end
    wires{1,z} = I;
    wires{2,z} = n;
    wires{3,z} = L_wire;
    wires{4,z} = R;
    wires{5,z} = P;
     
end
 
for i = 1:length(areaArray)
    srtr = strcat(num2str(guageArray(i)),'.txt');
    fid = fopen(srtr,'w');
    fprintf(fid,'%4s\t\t %4s\t\t %4s\t\t %4s\t\t  %4s\t\t\r\r', 'Current', 'No of turns', 'Length of wire', 'Resistance', 'Power' );
    for j = 1:length(I)
        fprintf(fid,'%4.1f \t\t %4.4f \t\t %4.4f \t\t %4.4f \t\t %4.4f\t\t\r',wires{1,i}(j),wires{2,i}(j),wires{3,i}(j),wires{4,i}(j),wires{5,i}(j));
    end
end

% figure(1)
% subplot(3,1,1)
% plot(I,n,'b','LineWidth',2.5,'MarkerSize',6);
% title (' Current vs Number of turns plot ');
% xlabel('Current(A)');
% ylabel('No.of turns');
% %ylim([480 650]);
% %xlim([0 2]);
% %set(gca,'YTick',480:50:650);
% grid;
%  
% subplot(3,1,2)
% plot(R,L_wire,'b','LineWidth',2.5,'MarkerSize',6);
% title (' Resistance vs length of wire plot ');
% xlabel('Resistance(ohm)');
% ylabel('Length of wire(m)');
% %ylim([480 650]);
% %xlim([0 2]);
% %set(gca,'YTick',480:50:650);
% grid;
%  
% subplot(3,1,3)
% plot(P,R,'b','LineWidth',2.5,'MarkerSize',6);
% title (' Power vs Resistance of wire ');
% xlabel('Power(watt)');
% ylabel('Resistance(ohm)');
% %ylim([480 650]);
% %xlim([0 2]);
% %set(gca,'YTick',480:50:650);
% grid;
%  
%  
% %figure(1);
% %plot(I,n);

wht2plot = 1:4:length(guageArray);
for i = wht2plot
    
    srtr = strcat(num2str(guageArray(i)),' guage wire');
    sid = figure('Name',srtr,'NumberTitle','off');
    
    subplot(3,1,1);
    title('Current V No of turns');
    plot(wires{2,i},wires{1,i},'r','LineWidth',2);
    xlabel('No of turns (nos)');
    ylabel('Current (A)');
    
    subplot(3,1,2);
    title('Power V No of turns');
    plot(wires{2,i},wires{5,i},'b','LineWidth',2);
    xlabel('No of turns (nos)');
    ylabel('Power (watts)');
    
    subplot(3,1,3);
    title('Length V No of turns');
    plot(wires{2,i},wires{3,i},'Color','#1d7526','LineWidth',2);
    xlabel('No of turns (nos)');
    ylabel('Length (m)');
    
    hold on
    
end

disp('simulation complete')
