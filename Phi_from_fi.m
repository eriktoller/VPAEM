function [ Phi ] = Phi_from_fi( fi,k )
% PHI_FROM_FI Calculates the discharge potential for hydraulic head in the
%             vertical plane.
%   VARIBALES
%   fi - hydraulic head
%   k - hydraulic conductivity
Phi = fi*k;
end