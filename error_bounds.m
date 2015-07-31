function data = error_bounds(W, central_R, Q, N_proj, v, data)
%ERROR_BOUNDS is the core code for computing 3 types of error bounds for
%binary tomography with constant column sum projection matrices without
%perturbation as in the paper: 
%   Bound on the quality of reconstructed images in binary tomography
%   K.J. Batenburg, W. Fortes, L. Hajdu, R. Tijdeman
%   Discrete Applied Mathematics, Vol. 161(15), 2236-2251, 2013
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% If reconstruction is not given then compute it
if isempty(central_R)
    central_R = ls_solver(W, Q, data.solver, data.maxit, data.tol);
end

% l1-norm of original binary image from its projections
norm_OIbyQ = norm(Q, 1)/N_proj;

% hypersphere's radius squared (Pythagora's theorem)
sq_radius = norm_OIbyQ - dot(central_R, central_R);

% r is the rounded (to binary) vector
% ordb is the sorted vector of increments
% Ixb are the indexes of the sorting
[r, b, ordb, Ixb] = round2binary(central_R);

% Vector of diference between R and its rounded (to binary) vector r
dif_Rr = central_R - r;

% Parameter R^2-T^2 from Theorem 2
parameter = sq_radius - dot(dif_Rr, dif_Rr);


% =========================== Error bounds ================================

% Error bounds for the number of pixel differences between any two binary
% solutions.
[EB_2binsol1, EB_2binsol2, EB_2binsol3, EB_2binsol4] = eb_any2binsol( ...
    sq_radius, ordb, parameter, Ixb, norm_OIbyQ, r);

%--------------------------------------------------------------------------

% Error bound for the number of pixel differences between the binary
% rounded vector r and any binary solution.
[EB_rxbinsol1, EB_rxbinsol2] = eb_rxbinsol(ordb, parameter, Ixb, ...
    norm_OIbyQ, r);

%--------------------------------------------------------------------------

% Error bound for the number of pixel differences between any given binary
% vector and any binary solution.

[EB_vecxbinsol1, EB_vecxbinsol2, EB_vecxbinsol3] = ...
    eb_vecxbinsol(ordb, parameter, Ixb, norm_OIbyQ, r, v, b);

%==========================================================================

% number of image pixels
n_pix = size(central_R, 1);

% output structure str
aux = data.aux;
data.r{aux} = r;

data.V1(aux, 1) = EB_2binsol1/n_pix; % error relative to image size
data.V2(aux, 1) = EB_2binsol2/n_pix; % error relative to image size
data.V3(aux, 1) = EB_2binsol3/n_pix; % error relative to image size
data.V4(aux, 1) = EB_2binsol4/n_pix; % error relative to image size

data.U1(aux ,1) = EB_rxbinsol1/n_pix; % error relative to image size
data.U2(aux, 1) = EB_rxbinsol2/n_pix; % error relative to image size

data.VX1(aux, 1) = EB_vecxbinsol1/n_pix; % error relative to image size
data.VX2(aux, 1) = EB_vecxbinsol2/n_pix; % error relative to image size
data.VX3(aux, 1) = EB_vecxbinsol3/n_pix; % error relative to image size

%