function F = cvpr_extract_EOHColor(img, grid_rows, grid_cols, threshold, Q)
% % cvpr_extract_EOHColor
% %     This function concatenates the image descriptors calculated from
% %     cvpr_extract_color and cvpr_extract_EOH to create an image
% %     descriptor that takes into account color and edges.
% % 
% % INPUT:
% %     img: Normalised image to calculate image descriptor for.
% %     grid_rows: Number of rows to split the image into.
% %     grid_cols: number of cols to split the image into.
% %     threshold: Threshold magnitude, edges smaller than this are
% %     ignored.
% %     Q: Number of quantisation level.
% % RETURN:
% %     F: Image descriptor representing the image.

F1 = cvpr_extract_color(img, grid_rows, grid_cols);
F2 = cvpr_extract_EOH(img, grid_rows, grid_cols, threshold, Q);
F = horzcat(F1, F2);

return;

