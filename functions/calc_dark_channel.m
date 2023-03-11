% ** INPUT **
% img = input image
% n = patch size (15)

% ** OUTPUT **
% J_dark = dark channel prior

function J_dark = calc_dark_channel(img, n) 
    img_min = min(img, [], 3);
    J_dark = ordfilt2(img_min, 1, ones(n, n), 'symmetric');
end