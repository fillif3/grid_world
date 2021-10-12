pa = 1.2;
fi=3;
g=9.81;
Height=5;
C=1005 ;
deltaT=20*60;
beta=10^6;

To=273+12;
Tref=273+21;
valsx = linspace(To+0.001,Tref,100);
valsu=linspace(0.01,1,100);
for i =valsx
    for j=valsu
        H=zeros(2);
        H(2,1)=C*deltaT*fi*sqrt(g*Height)*pa*(To*(Tref+i)-2*i^2)/(i^2*sqrt(2-2*To/i));
        H(1,2)=H(2,1);
        H(2,2)=2*beta+C*deltaT*sqrt(g*Height)*pa*j*To*(To*(3*Tref+i)-4*Tref*i)/(2*i^3*(i-To)*sqrt((2-2*To/i)));
        k=eig(H)
        d=1
    end
end