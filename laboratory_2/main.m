l = 1.18;
b = 0.00305;
h = 0.03008;

ro = 1.76*10^(-8);
ST = 2*(b+h)*1;
alfa = 0.0042;
k= 10;
Rc= 0.0001;
uRc = 0.01;
Rx = ro*l/(b*h);
Up = 0.0035/100;
Vp = 0.1;

k2 = (alfa*Rx)/(k*ST);
k0 = -uRc*0.05;
k1 = -0.05*Up*Vp*(1/Rc+1/Rx);

I = linspace (5,25,1000);
eT=k2*I.^2;
uRx=-k0-k1./I;
plot(I, eT, 'b', I, uRx, 'r')
Ip = find((eT-uRx)>0);
Im=I(Ip(1));
hold on
plot(Im,k2*Im.^2, '*')
xlabel('I (A)')