

%% input parameter
clear
clc
multimeter="";                         % multimeter name: Fluke 189, HP 974A, Keysight U1253B, Agilent 34401A
meas_type="";                          % Vdc, R, Idc,
x_=[ ];                                % x_ = column vector of meas
filename = 'Spec_mul.xlsx';
sheet = multimeter;

%%
T = readtable(filename,'Sheet',sheet); % ALL spec data

%% Specs table
rows = find(strcmp(T.meas_type, meas_type)); % selected rows
Specs = T(rows,:);

%% Specs arrays
FS=Specs.range;
U_G = Specs.U_G;  % reading uncertainty coeffcient

% FS uncertainty calculation 
if Specs.U_FS(1)<1
     U_FS=FS.*Specs.U_FS/100;
else
     U_FS = Specs.Q.*Specs.U_FS;
end
    
%% Uncertainty computation
N = length(x_); % number of meas
U_G_ = NaN(size(x_)); % preallocation
U_FS_ = NaN(size(x_)); % preallocation

for k = 1:N % k-th meas
    
    i=find(x_(k)<FS, 1 ); % row in range evaluation
    range(k)=FS(i);
    U_G_(k) = U_G(i)/100*abs(x_(k)); % gain unc of k-th meas
    U_FS_(k) = U_FS(i); % FS unc of k-th meas
end

%% plot Uncertainty bounds
Nr=length (U_FS);                          % number og ranges
x = NaN(1,Nr*2);                           % preallocation
............