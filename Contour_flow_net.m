function [] = Contour_flow_net(X,Y,Grid,lvs,ln_wdth)
% CONTOUR_FLOW_NET Program which contours the flow net for a given grid
%   The program contours a flow net for a grid of complex potentials.
%
%   VARIABLES
%   X - x-values for grid (double vector)
%   Y - y-values for grid (double vector)
%   Grid - grid of complex potential (complex matrix)
%   lvs - number of contour levels (integer)
%   ln_wdth - line width (double)
%
%   LATEST UPDATE
%   2021-10-26
%
%   AUTHOR
%   Erik Toller,
%   Department of Earth Sciences, Uppsala University, Sweden

% Find the max and min value for the stream lines
im_max=max(max(imag(Grid)));
im_min=min(min(imag(Grid)));
% Calculate the difference between max an min
D=im_max-im_min;
% Calcualte the step size for the given number of levels
del=D/lvs;

% Find the max and min value for the stream lines
re_max=max(max(real(Grid)));
re_min=min(min(real(Grid)));
% Calculate the difference between max an min
D=re_max-re_min;
% Calcualte the number of levels using teh same step size as for the
% stream lines
lvsr=round(D/del);

% Contour stream lines and equipotentials
contour(X, Y,real(Grid),lvsr,'r','LineWidth',ln_wdth);
contour(X, Y,imag(Grid),lvs,'b','LineWidth',ln_wdth);
end