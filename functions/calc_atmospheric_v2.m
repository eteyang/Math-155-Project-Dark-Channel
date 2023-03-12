% ** INPUT **
% img = input image 
% n = patch size used for dark channel (15)

% ** OUTPUT **
% A = atmospheric light
% norm_img = normalized haze image

function [A,norm_img] = calc_atmospheric_v2(img, n) 
    J_dark = calc_dark_channel(img, 15);
    [h, w] = size(img, 1:2);
    [count, bins] = imhist(J_dark, n);
    i = length(count);
    num_bright_pixels = 0;
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);

    while(num_bright_pixels < 0.001 * h * w)
        num_bright_pixels = num_bright_pixels + count(i);
        i = i - 1;
    end

   threshold = bins(i);

   intensity=zeros(num_bright_pixels,1);
    for t=1:num_bright_pixels
        for m=1:h
            for n=1:w
                if (J_dark(m,n)>=threshold)
                    intensity(t,1)=(1/3)*(R(m,n)+G(m,n)+B(m,n));
                end
            end
        end
    end

   A(1:h,1:w)=max(intensity);

    norm_img = img;
    norm_img(:, :, 1) = norm_img(:, :, 1) / A(1);
    norm_img(:, :, 2) = norm_img(:, :, 2) / A(2);
    norm_img(:, :, 3) = norm_img(:, :, 3) / A(3);
end