% ** INPUT **
% img = input image 
% n = patch size used for dark channel (15)

% ** OUTPUT **
% A = atmospheric light
% norm_img = normalized haze image

function [A, norm_img] = calc_atmospheric(img, n) 
    % compute dark channel prior
    J_dark = calc_dark_channel(img, 15);
    [h, w] = size(img, 1:2);
    
    % compute theshold for brightess pixels in dark channel 
    [count, bins] = imhist(J_dark, n);
    i = length(count);
    num_bright_pixels = 0;
    while(num_bright_pixels < 0.001 * h * w)
        num_bright_pixels = num_bright_pixels + count(i);
        i = i - 1;
    end
    threshold = bins(i);
    
    % create binary mask for brightess pixels in dark channel
    mask = J_dark > threshold;
    
    % calculate image intensity
    img_intensity = mean(img, 3);
    
    % using the masked image intensity, get the (x,y) location of 
    % the brightess pixel 
    [~, A_location] = max(img_intensity .* mask, [], 'all', 'linear');
    [A_r, A_c] = ind2sub([h, w], A_location);
    
    % using computed (x,y) location, get the color at that location in the
    % original image and store that as the atmospheric light
    A = img(A_r, A_c, :);
    
    % compute the haze normalized image used for transmission calculation
    norm_img = img;
    norm_img(:, :, 1) = norm_img(:, :, 1) / A(1);
    norm_img(:, :, 2) = norm_img(:, :, 2) / A(2);
    norm_img(:, :, 3) = norm_img(:, :, 3) / A(3);
end