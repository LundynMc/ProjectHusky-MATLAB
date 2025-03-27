% Douglas Sea State 3 Simulation

%Randomized wave parameters for Sea State 3
waves=3; %Number of wave components
t=0:0.1:50; %time
x=linspace(0,10,100);
y=linspace(0,10,100);

%Creating 3D grid for x, y , and t
[X,Y,T]=meshgrid(x,y,t);

%Making sure zTotal is the same size as x, y, and t
zTotal=zeros(size(x));

for i=1:waves
    %wave properties (randomized within sea state 3 parameters)
    A=0.5+(1.25-0.5)*rand; %Amplitude
    T_i=6+(8-6)*rand; %Period
    lambda=(9.8*T_i^2)/(2*pi); %Wavelength

   %Derived wave parameters
   omega=2*pi/T_i;
   k=2*pi/lambda;

   %Adding wave components
   zTotal=zTotal+A*sin(k*X*cos(45)+k*Y*sind(45)-omega*T);
end

%final wave height
z=zTotal;

%Heave, pitch, and roll calculation
heave=mean(z,'all'); %Average heave
[dz_dx, dz_dy]=gradient(z); %Pitch and roll partial derivatives
pitch=atan(mean(dz_dy,'all')); %Approx pitch from y-gradient
roll=atan(mean(dz_dx,'all')); %Approx roll from x-gradient

N=6; %Number of actuators
nStep=length(t); %Number of time steps

%Initialize motion arrays for Stewart platform
xMotion=zeros(1,nStep); %No x lateral motion
yMotion=zeros(1,nStep); %No y lateral motion
zMotion=heave*ones(1,nStep); %Vertical motion from wave
thetaMotion=pitch*ones(1,nStep); %Pitch from wave
phiMotion=roll*ones(1,nStep); %Roll from wave
psiMotion=zeros(1,nStep); %No yaw

%Inverse kinematics calculation for platform motion
[topCords,b,p,actLengths,t] = invKin(xMotion,yMotion,zMotion,thetaMotion,phiMotion,psiMotion,nStep,N);

%Plot the Stewart platform motion based on the calculated actuator positions
plot3D(b,p,topCords,xMotion,yMotion,zMotion,N,nStep);
