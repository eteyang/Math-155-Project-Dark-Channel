% ** INPUT **
% img = input image 
% t = coarse transmission map
% n = patch size used for dark channel (n, n)

% ** OUTPUT **
% t_refined = refined transmission map

function t_refined = refine_transmission(t, img, n) 
    t = ordfilt2(t, 1, ones(n, n), 'symmetric');
    t_refined = imguidedfilter(t, img, 'neighborhoodsize', 40,...
        'degreeofsmoothing', 1e-3);
end