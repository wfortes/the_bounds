function [EB_rxbinsol1, EB_rxbinsol2] = eb_rxbinsol(ordb, parameter, Ixb, ...
    norm_OIbyQ, r)
%EB_ANY2BINSOL computes 2 error bound for the number of pixel differences 
%   between the binary rounded vector r and any binary solution.
%   Input parameters are computed in error_bounds.m
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% Theorem 2
EB_rxbinsol1 = error_bound4r(ordb, parameter);

% Theorem 5
EB_rxbinsol2 = error_bound4r_limitones(parameter, ordb, Ixb, norm_OIbyQ, r);
