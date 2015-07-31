function [EB_vecxbinsol1, EB_vecxbinsol2, EB_vecxbinsol3] = ...
    eb_vecxbinsol(ordb, parameter, Ixb, norm_OIbyQ, r, v, b)
%EB_VECXBINSOL computes 3 error bound for the number of pixel differences 
%   between the binary rounded vector r and any binary solution.
%   Input parameters are computed in error_bounds.m
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% Corollary 5
EB_vecxbinsol1 = error_bound4r(ordb, parameter) + dot(r-v,r-v);

% Theorem 4
dif = r-v;
b = b(dif ~= 0);
ordbv = sort(b);

EB_vecxbinsol2 = error_bound4r(ordbv, parameter) + dot(r-v,r-v);

% Corollary 7
EB_vecxbinsol3 = error_bound4r_limitones(parameter, ordb, Ixb, norm_OIbyQ, r) + dot(r-v,r-v);