%This example computes 3 types of error bounds for binary tomography 
%with constant column sum projection matrices without perturbation as in 
%the paper: 
%   Bound on the quality of reconstructed images in binary tomography
%   K.J. Batenburg, W. Fortes, L. Hajdu, R. Tijdeman
%   Discrete Applied Mathematics, Vol. 161(15), 2236-2251, 2013
%
%The bounds are on the difference between:
%   any 2 binary solutions of the reconstruction problem
%   the rounded (to binary) central reconstruction and any binary solution
%   a given binary reconstruction and any binary solution
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% ------------- parameters:
img_index = 2; % select image index from 1 to 5
img_sz = 64; % select image dimension 32, 64, 128, 256, 512
N_proj_set = [2, 4 ,8, 12, 16, 20]; %Set of number of projection angles from 1 to 200
% -------------

data = initialize_data_str; % initialize variables for data structure
[dir_a, dir_b] = mkdirvecs(20); % create directions for projection matrix

% loads image
P = img_read(img_sz, img_index);
P = reshape(P,img_sz^2,1);
P = double(P);
P = P/norm(P,inf); % only for binary images

data.aux = 1;
for N_proj = N_proj_set
    
    % Projection matrix
    M = mkmatrix(img_sz, img_sz, dir_a(1:N_proj), dir_b(1:N_proj));
    % Projetion of image P
    Q = M*P; 
    % central reconstruction
    central_R = ls_solver(M, Q, [], [], []); 
    
    % A binary reconstruction from a DART algorithm implementation
    v = dart(Q, img_sz, N_proj, [0 1], 'sirt', [], [], [], [], [], M);
    v = reshape(v{end}, img_sz^2,1);
    data.v = v;
    
    % Error bounds computation
    [data] = error_bounds(M, central_R, Q, N_proj, v, data);
    
    % number of image pixels
    n_pix = size(P, 1);
    % Difference between original image P and r, the rounded (to binary)
    % central recostruction, for comparison with bounds
    r = data.r{data.aux};
    data.Pr(data.aux, 1) = norm(P-r, 1)/n_pix;
    % Difference between original image P and v, a binary reconstruction,
    % for comparison with bounds
    data.Pv(data.aux, 1) = norm(P-v, 1)/n_pix;
    
    data.aux = data.aux+1;
end
% ---------- Graphics -------------
build_graph_error_bounds(data, N_proj_set)
%