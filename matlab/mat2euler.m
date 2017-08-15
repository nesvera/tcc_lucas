function [phi,theta,psi]=mat2euler(C)
%#eml
% Convert from DCM to Euler angles in the sequence 3-2-1
phi=atan2(C(2,3),C(3,3));
theta=-asin(C(1,3));
psi=atan2(C(1,2),C(1,1));