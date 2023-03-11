% ** INPUT **
% img = input image 
% n = patch size used for dark channel (15)

% ** OUTPUT **
% A = atmospheric light
% norm_img = normalized haze image

function [A, norm_img] = calc_atmospheric(img, n) 
    J_dark = calc_dark_channel(img, 15);
    [h, w] = size(img, 1:2);
    [count, bins] = imhist(J_dark, n);
    i = length(count);
    num_bright_pixels = 0;
    while(num_bright_pixels < 0.001 * h * w)
        num_bright_pixels = num_bright_pixels + count(i);
        i = i - 1;
    end
    threshold = bins(i);
    mask = J_dark > threshold;
    img_intensity = mean(mask, 3);
    [~, A_location] = max(img_intensity .* mask, [], 'all', 'linear');
    [A_r, A_c] = ind2sub([h, w], A_location);
    A = img(A_r, A_c, :);
    norm_img = img;
    norm_img(:, :, 1) = norm_img(:, :, 1) / A(1);
    norm_img(:, :, 2) = norm_img(:, :, 2) / A(2);
    norm_img(:, :, 3) = norm_img(:, :, 3) / A(3);
end