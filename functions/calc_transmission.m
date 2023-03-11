% ** INPUT **
% J_dark = dark channel of haze normalized image 
% w = parameter for aerial perspective (0.95)
% A = atmospheric light

% ** OUTPUT **
% t = estimated transmission

function t = calc_transmission(J_dark, w) 
    t = 1 - J_dark * w;
end