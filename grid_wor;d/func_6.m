function cost= func(inputs)
% Prepare student's id based params
E1 = 1+1;
E2 = 2+5;
E3 = 8+3;
% Preapre parameters
Va = 1430;
Vw = [17.5,15,80];
Aw = [350,286,286];
Ca = 1005;
Cw = [900,840,840];
pa = [1.2];
pw= [2500,2000,2000];
alfaw = [0.085,0.2,0.6];
tau= 0.9;
H=5;
g=9.81;
phi=3;
ha=5;
ho=25;
lambda=4.5*10^(-8);
deltat = 5*60;
Tref=21+273;
I = zeros(1,144);
I(1,1:47) = ones(1,47)*(300+E1);
I(1,48:96) = ones(1,49)*(700+E1);
I(1,97:144) = ones(1,48)*(300+E1);
To = zeros(1,145);
To(1,1:47) = ones(1,47)*(12+0.1*E2)+273;
To(1,48:96) = ones(1,49)*(18+0.1*E2)+273;
To(1,97:145) = ones(1,49)*(17+0.1*E2)+273;
qp = zeros(1,144);
qp(1,1:47) = ones(1,47)*(5000+10*E3);
qp(1,48:96) = ones(1,49)*(25000+10*E3);
qp(1,97:144) = ones(1,48)*(20000+10*E3);
Tsky = To-8;
beta = 10^6;
beta_penalty = 10^10;

% Prepare inputs
z1 = inputs(1:145);
z2 = inputs(146:289);
u = sin(z1)/2+0.5;
v = sin(z2)/2+0.5;
x_previous=[16,16,16,16]+273;
% Start calulcating costs
m = pa*u(1)*phi*sqrt(2*g*H*max(0,1-To(1)/x_previous(1)));
cost =m*Ca*abs(x_previous(1)-Tref)*deltat+beta*(x_previous(1)-Tref)^2;
x=zeros(4,1);
% For each step, add value to cost
for k=1:144
    x1_delta = qp(k)+m*Ca*(To(k)-x_previous(1));
    for i=1:3
        x1_delta=x1_delta+ha*Aw(i)*(x_previous(i+1)-x_previous(1));
    end
    x(1) = x_previous(1)+x1_delta*deltat/(pa*Va*Ca);
    x(2) = x_previous(2)+(v(k)*I(k)*alfaw(1)+lambda*(Tsky(k)^4-x_previous(2)^4)+...
        ho*(To(k)-x_previous(2))+ha*(x_previous(2)-x_previous(1)))*Aw(1)*deltat/(pw(1)*Vw(1)*Cw(1));
    x(3) = x_previous(3)+(I(k)*alfaw(2)+lambda*(Tsky(k)^4-x_previous(3)^4)+...
        ho*(To(k)-x_previous(3))+ha*(x_previous(3)-x_previous(1)))*Aw(2)*deltat/(pw(2)*Vw(2)*Cw(2));
    x(4) = x_previous(4)+(0.5*v(k)*I(k)*tau*alfaw(3)+...
        ha*(x_previous(4)-x_previous(1)))*Aw(3)*deltat/(pw(3)*Vw(3)*Cw(3));
    m = pa*u(k+1)*phi*sqrt(2*g*H*max(0,1-To(k+1)/x(1)));
    cost = cost+m*Ca*abs(x(1)-Tref)*deltat+beta*(x(1)-Tref)^2;
    disp(beta_penalty*max(0, 0.5 - m))
    disp(m)
    x_previous=x;
end

end