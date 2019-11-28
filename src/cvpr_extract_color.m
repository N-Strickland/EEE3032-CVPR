function F = cvpr_extract_color(img, grid_rows, grid_cols)
% % cvpr_extract_color
% %     This function splits the image into grids and calculates the
% %     average color of each cell in each grid. Then concatenates this
% %     into the image descriptor.
% % 
% % INPUT:
% %     img: Normalised image to calculate image descriptor for.
% %     grid_rows: Number of rows to split the image into.
% %     grid_cols: number of cols to split the image into.
% % RETURN:
% %     F: Image descriptor representing the image. 

F = [];
[rows, cols, x] = size(img);
grid_height = floor(rows / grid_rows);
grid_width = floor(cols / grid_cols);

for row = 1:grid_height:(rows - mod(rows, grid_rows))
    for col = 1:grid_width:(cols - mod(cols, grid_cols)) 
        if (row + grid_height > rows) to_row = rows;
        else to_row = row + grid_height - 1; end
        
        if (col + grid_width > cols) to_col = cols;
        else to_col = col + grid_width - 1; end
        
        current_grid = img(row:to_row, col:to_col, :);
        
        mean_red = mean(mean(current_grid(:, :, 1)));
        mean_green = mean(mean(current_grid(:, :, 2)));
        mean_blue = mean(mean(current_grid(:, :, 3)));
        total_mean = mean_red + mean_green + mean_blue;
        
        F = horzcat(F, [mean_red, mean_green, mean_blue]./total_mean);
    end
end
return;