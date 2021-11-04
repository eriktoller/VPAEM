%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           RUN VPAEM                                                     %
%           Created by: Erik Toller,                                      %
%                       erik.toller@geo.uu.se                             %
%                       Department of Earth Sciences, Uppsala University  %
%                       SWEDEN                                            %
%                                                                         %
%           Last updated: 2021-10-21                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars
close all
clc

%% GLOBAL PARAMETERS
W_uni  = -1i/1i;
k = 1;
rho = 10;
g = 9.82;
h = 0;
zref = complex(1,1);
fi0 = imag(zref)+.1;

%% BLOCKING FRACTURES
% load data_files/55_frac.mat;
load data_files/14_160_frac.mat
z1a = z1;
z2a = z2;

z1a = [];
z2a = [];

ka = ones(1,length(z1a)).*k./100;
ba = ones(1,length(z1a));

%% DRAINING FRACTURES
% load data_files/55_frac.mat;
load data_files/14_160_frac.mat
z1b = z1;
z2b = z2;

z1b = [];
z2b = [];

kb = ones(1,length(z1b)).*k.*100;
bb = ones(1,length(z1b));

%% CONSTANT PRESSURE ELEMENTS (TUNNELS)
load data_files/horseshoe_48;
z1c = z1/6 - 2/6*1i/2 + .05;
z2c = z2/6 - 2/6*1i/2 + .05;
z1c = [];
z2c = [];

%% INHOMOGENEITIES
z1d = [complex(-.7,.7), complex(-.7,-.7), complex(.7,-.7),complex(.7,.7)];
z2d = [complex(-.7,-.7), complex(.7,-.7), complex(.7,.7),complex(-.7,.7)];
% z1d = [];
% z2d = [];
kd = k.*10;

%% WELLS
zw = complex(0,0);
Qw = -2;
rw = .03;
% zw = [];

%% COEFFICIENTS, PLOT DIMENSIONS AND RESOLUTION
% Coefficients
ma = 100;
mfara = ma*10;
mb = 90;
mfarb = mb*10;
mc = 10;
mfarc = mc*10;
md = 50;
mfard = md*20;
Nc = 100; % Number of integral points
N = 2; % Multiplier for coefficient sovlers

% Plot window
xfrom = -1;
xto = 1;
yfrom = -1;
yto = 1;
Nx = 800;
Ny = Nx;
lvs = 20;

%% EXPORT INPUT DATA
% Pre-calculations
na = length(z1a);
nb = length(z1b);
nc = length(z1c);
nd = length(z1d);
nw = length(zw);

Phi0 = Phi_from_fi(fi0,k);
fi_tunnel = imag((z1c+z2c)/2);
Phi_const = zeros(1,nc+1); 
for ii = 1:nc
    Phi_const(ii) = Phi_from_fi(fi_tunnel(ii),k);
end
Phi_const(nc+1) = Phi0;

if nw == 0
    rw = [];
    Qw = [];
end
if na == 0
    z1a = [];
    z2a = [];
    ka = [];
    ba = [];
end
if nb == 0
    z1b = [];
    z2b = [];
    kb = [];
    bb = [];
end
if nc == 0
    z1c = [];
    z2c = [];
end
if nd == 0
    z1d = [];
    z2d = [];
end

% Write the bin-files for C++ program
A = [ h, rho, g, k, real(W_uni), imag(W_uni), nw, ...
    mb, mfarb, ma, mfara, N, nb, na, mc, mfarc, Nc, nc, md, mfard, nd, real(zref), imag(zref),...
    real(zw), imag(zw), rw, Qw,...
    real(z1b), imag(z1b), real(z2b), imag(z2b),...
    real(z1a), imag(z1a), real(z2a), imag(z2a), kb, bb, ka, ba,...
    real(z1c), imag(z1c), real(z2c), imag(z2c), Phi_const,...
    real(z1d), imag(z1d), real(z2d), imag(z2d), kd];
input_file = fopen('geometry_data.bin','w');
fwrite(input_file, A, 'double');
fclose(input_file);

B = [xfrom,xto,yfrom,yto,Nx,Ny]; % Vector to write
plot_file = fopen('plot_data.bin','w');
fwrite(plot_file, B, 'double');
fclose(plot_file);

%% RUN THE C++ FILE
system('exe_VPAEM.exe');

%% IMPORT THE RESULTS
data_file = fopen('data.bin', 'r'); 
dim_file = fopen('dim_data.bin', 'r');
[A,~] = fread(data_file,'double');
[B,~] = fread(dim_file,'double');
Nx = B(1);
Ny = B(2);
nb = B(3);
na = B(4);
nc = B(5);
nd = B(6);
nw = B(7);
error_str = ['Max ','Mean ','Median'];
error_a = [B(8),B(9),B(10)];
error_b = [B(11),B(12),B(13)];
error_c = [B(14),B(15),B(16)];
error_d = [B(17),B(18),B(19)];
zw = zeros(1,nw);
rw = zeros(1,nw);
Qw = zeros(1,nw);
z1b = zeros(1,nb);
z2b = zeros(1,nb);
z1a = zeros(1,na);
z2a = zeros(1,na);
z1c = zeros(1,nc);
z2c = zeros(1,nc);
z1d = zeros(1,nd);
z2d = zeros(1,nd);
Qc = zeros(1,nc);
pos = 19;
for ii = 1:nw
    re = pos + ii;
    im = pos + nw + ii;
    zw(ii) = complex(B(re),B(im));
end
pos = pos + 2*nw;
for ii = 1:nw
    get = pos + ii;
    rw(ii) = B(get);
end
pos = pos + nw;
for ii = 1:nw
    get = pos + ii;
    Qw(ii) = B(get);
end
pos = pos + nw;
for ii = 1:nb
    re = pos + ii;
    im = pos + nb + ii;
    z1b(ii) = complex(B(re),B(im));
    re = pos + nb*2 + ii;
    im = pos + nb*3 + ii;
    z2b(ii) = complex(B(re),B(im));
end
pos = pos + 4*nb;
for ii = 1:na
    re = pos + ii;
    im = pos + na + ii;
    z1a(ii) = complex(B(re),B(im));
    re = pos + na*2 + ii;
    im = pos + na*3 + ii;
    z2a(ii) = complex(B(re),B(im));
end
pos = pos + 4*na;
for ii = 1:nc
    re = pos + ii;
    im = pos + nc + ii;
    z1c(ii) = complex(B(re),B(im));
    re = pos + nc*2 + ii;
    im = pos + nc*3 + ii;
    z2c(ii) = complex(B(re),B(im));
end
pos = pos + 4*nc;
for ii = 1:nc
    get = pos + ii;
    Qc(ii) = B(get);
end
pos = pos + nc;
if nc > 0
    Phi0 = B(pos+1);
    pos = pos + 1;
end
for ii = 1:nd
    re = pos + ii;
    im = pos + nd + ii;
    z1d(ii) = complex(B(re),B(im));
    re = pos + nd*2 + ii;
    im = pos + nd*3 + ii;
    z2d(ii) = complex(B(re),B(im));
end
pos = pos + 4*nd;


x_vec = A(1:Nx);
y_vec = A((Nx+1):(Nx+Ny));
grid_FN = zeros(Nx,Ny);
grid_p = zeros(Nx,Ny);
start = Nx+Ny;
for ii = 1:Nx
    for jj = 1:Ny
        re = start + jj;
        im = start + Nx + jj;
        grid_FN(jj,ii) = complex(A(re),A(im));
    end
    start = start + Nx + Ny;
end
start = start + 1;
for ii = 1:Nx
    stop = start + Nx -1;
    grid_p(:,ii) = A(start:stop);
    start = stop + 1;
end

%% PLOT THE RESULTS
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultAxesFontSize',15)

if nc > 0
    disp(' ')
    disp(['Tunnel inflow = ',num2str(sum(Qc))])
end

disp(' ')
disp(['Contour levels set to: ',num2str(lvs)])

% Ploting
disp('figure (1/2) - Flow Net')
create_figure()
Contour_flow_net(x_vec,y_vec,grid_FN,lvs,1.0)
Plot_line(z1b,z2b,'black',1.0)
Plot_line(z1a,z2a,'black',1.0)
Plot_line(z1c,z2c,'black',1.0)
Plot_line(z1d,z2d,'black',1.0)
Plot_circle(zw,rw,'black',1.0)
axis([x_vec(1) x_vec(end) y_vec(1) y_vec(end)])

disp('figure (2/2) - Pressure Contours')
create_figure()
lvs_p = linspace(0,300,lvs);
contourf(x_vec, y_vec, real(grid_p),lvs_p,':');
colormap cool
Plot_line(z1b,z2b,'black',1.0)
Plot_line(z1a,z2a,'black',1.0)
Plot_line(z1c,z2c,'black',1.0)
Plot_line(z1d,z2d,'black',1.0)
Plot_circle(zw,rw,'black',1.0)
axis([x_vec(1) x_vec(end) y_vec(1) y_vec(end)])

%% SAVE WORKPLACE DATA
% Save the data as todays date + version
today = date;
str_file = ['data_files\simulation_',today,'_v0.mat'];
while isfile(str_file)
    vpos = find(str_file == 'v');
    version = str2double(str_file((vpos(end)+1):end-4))+1;
    str_file = [str_file(1:vpos(end)),num2str(version),'.mat'];
end
save(str_file,...
    'ba','bb','fi0','fi_tunnel','g','grid_FN','grid_p','h','k','ka',...
    'kb','kd','lvs','ma','mb','mc','md','mfara','mfarb','mfarc','mfard',...
    'N','na','nb','nc','Nc','nd','Nx','Ny','nw','Phi0','Phi_const',...
    'Qc','Qw','rho','rw','today','W_uni',...
    'x_vec','xfrom','xto','y_vec','yfrom','yto','z1','z1a','z1b','z1c',...
    'z1d','z2','z2a','z2b','z2c','z2d','zref','zw', 'error_str',...
    'error_a','error_b','error_c','error_d')
