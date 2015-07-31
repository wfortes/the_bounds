function [EB_2binsol1, EB_2binsol2, EB_2binsol3, EB_2binsol4] = ...
    eb_any2binsol(sq_radius, ordb, parameter, Ixb, norm_OIbyQ, r)
%EB_ANY2BINSOL computes 4 error bounds for the number of pixel 
%  differences between any two binary solutions. 
%  Input parameters are computed in error_bounds.m
%
% Wagner Fortes 2014/2015 wfortes@gmail.com


% Theorem 1
EB_2binsol1 = 4*sq_radius;

% Corollary 4
EB_2binsol2 = 2*error_bound4r(ordb, parameter);

% Theorem 3
EB_2binsol3 = error_bound4r(ordb, 2*parameter);

% Corollary 6
EB_2binsol4 = 2*error_bound4r_limitones(parameter, ordb, Ixb, norm_OIbyQ, r);