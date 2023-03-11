% img = input image 
% A = atmospheric light
% t = estimated transmission
% t0 = lower bound on transmission (0.1)

% ** OUTPUT **
% J = final scene radiance or haze free image

function J = recover_scene_radiance(img, A, t, t0) 
    J = (img - A) ./ max(t, t0) + A;
end