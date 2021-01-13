function [qd,qdDot,qdDotDot]  = des_trajectory(t)
%#codegen

% This block supports an embeddable subset of the MATLAB language.
% See the help menu for details. 

qd1=cos(0.5*t);
qd2=2*cos(t);

qd1_dot=-0.5*sin(0.5*t);
qd2_dot=-2*sin(t);

qd1_dotDot = -0.25*cos(0.5*t);
qd2_dotDot = -2*cos(t);

qd=[qd1;qd2];
qdDot = [qd1_dot;qd2_dot];
qdDotDot = [qd1_dotDot; qd2_dotDot];


end
