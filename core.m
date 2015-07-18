function [info] = core(type,img_index,N_proj,img_sz,aux,info)

% this is the core of the code without perturbation

% if ~isempty(info.M)
%     M = info.M;
% else
if strcmp(type,'grid')
    [dir_a,dir_b]=mkdirvecs(20);
    M = mkmatrix(img_sz,img_sz,dir_a(1:N_proj),dir_b(1:N_proj));
else
    address = '/ufs/fortes/Link to PhD_files/Load/';
%     address = '/ufs/fortes/Link to PhD_files/Load/angles_eq_distr/';
    M = loadmatrix(address,img_sz,N_proj,type,'matrix');
end

if isempty(info.invader)
P = img_read(img_index,img_sz);
else
    P = info.invader;
end
P = reshape(P,img_sz^2,1);
P = double(P);
P = P/norm(P,inf); % only for binary images
Q = M*P;

% if ~isempty(info.R)
%     R = info.R;
% else
[R, res, sol] = cgls_W(M, Q,[], 100, 1e-10);
% end
npix = size(R,1); % number of pixels

% computing norm(x) from its projection
normPbyQ = norm(Q,1)/N_proj;

% square of radius
sqradius = normPbyQ-dot(R,R);

% obtain the rounded vector and the vector of increment b
[r, b, ordb, Ix, alpha] = round2binary(R);

% Computes the % of wong pixels in r
Rr = norm(P-r,1)/npix;

parameter = sqradius - dot(alpha,alpha);

% bound the number of wrong pixels
lim = 'notlimited'; % limited or notlimited
s_aux = bnwpixr(ordb,parameter,Ix,normPbyQ,r,lim);
s = s_aux/npix;
[V,V1,V2,~,~] = variability(npix,sqradius,s,ordb,parameter,Ix,normPbyQ,r,lim);
%
s_aux = bnwpixr(ordb,parameter,Ix,normPbyQ,r,'limited');
s_imp = s_aux/npix;
[~,V3,V4,~,~] = variability(npix,sqradius,s_imp,ordb,parameter,Ix,normPbyQ,r,'limited');

V5 = dif2binsols_limitones(parameter,ordb,Ix,r)/npix;
% output structure
% str info
info.img_index = img_index;
info.img_sz = img_sz;
info.proj(aux,1) = N_proj;
info.type = type;

info.P{aux} = P;
info.R{aux} = R;
info.r{aux} = r;
info.Rr(aux,1) = Rr;
info.sqradius(aux,1) = sqradius;
info.V(aux,1) = V;
info.s(aux,1) = s;
info.V1(aux,1) = V1; % 2s
info.V2(aux,1) = V2; % 

info.s_imp(aux,1) = s_imp;
info.V3(aux,1) = V3; % 2s improved by norm
info.V4(aux,1) = V4; % V2 improved by norm
info.V5(aux,1) = V5;