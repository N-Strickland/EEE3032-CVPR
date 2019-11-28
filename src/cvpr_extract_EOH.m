function F = cvpr_extract_EOH(img, grid_rows, grid_cols, threshold, Q)
% % cvpr_extract_EOH
% %     This function first converts a normalised image to its grayscale
% %     representation then applies a sobel filter to highlight edges. Any edges
% %     with a magnitude lower than the threshold value are ignored. The edges
% %     are then added to a edge orientation histogram for each grid.
% % 
% % INPUT:
% %     img: Normalised image to calculate image descriptor for.
% %     grid_rows: Number of rows to split the image into.
% %     grid_cols: Number of cols to split the image into.
% %     threshold: Threshold magnitude, edges smaller than this are
% %     ignored.
% %     Q: Number of quantisation level.
% % RETURN:
% %     F: Image descriptor representing the image.

F = [];
bin_segments = linspace(0, 2*pi, Q + 1);

[rows, cols, x] = size(img);
grid_height = floor(rows / grid_rows);
grid_width = floor(cols / grid_cols);

grayscale_img = rgb2gray(img);
Hx = [1, 0, -1; 2, 0, -2; 1, 0, -1]./4;
Hy = [1, 2, 1; 0, 0, 0; -1, -2, -1]./4;
Gx = imfilter(grayscale_img, Hx, 'replicate');
Gy = imfilter(grayscale_img, Hy, 'replicate');
mag = sqrt(Gx.^2 + Gy.^2);
orientation = atan2(Gx,Gy);
threshold_mags = (mag > threshold);
orientation = (orientation + pi).*threshold_mags;

for row = 1:grid_height:(rows - mod(rows, grid_rows))
    for col = 1:grid_width:(cols - mod(cols, grid_cols)) 
        if (row + grid_height > rows) to_row = rows;
        else to_row = row + grid_height - 1; end
        
        if (col + grid_width > cols) to_col = cols;
        else to_col = col + grid_width - 1; end
        
        current_grid =  orientation(row:to_row, col:to_col, :);
 
        hist_count = [];
        for i = 1:(length(bin_segments) - 1)
            count = length(find((current_grid >= bin_segments(i)) & (current_grid < bin_segments(i + 1))));
            hist_count = [hist_count, count]; % accidently made my own histogram from scratch
        end
        
        hist_count = hist_count ./ sum(hist_count);
        F = [F hist_count];    
    end
end
return;