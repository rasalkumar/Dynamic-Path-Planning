%%model variables and constants
C1 = 1200;
C2 = 1200;
m = 0.5;
I = 0.0338;
a = 0.143;
b = 0.117;
vx = 0.5*(5/18);
%%calculations
a11 = -(C1+C2)/(m*vx);
a12 = ((-(a*C1)+(b*C2))/(m*vx))-vx;
a21 = (-((a*C1)-(b*C2))/(I*vx));
a22 = -((a^2)*C1 + (b^2)*C2)/(I*vx) ;
b1 = C1/m ; 
b2 = a*C1/I ; 
%% Inputs for the model
A = [a11 a12; a21 a22];
B = [b1 b2]' ; 
d = (20/12)/100;
