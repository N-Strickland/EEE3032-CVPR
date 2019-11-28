function img_category = cvpr_image_category(filename)
% % cvpr_image_category
% %     This function is used to identify which category an image belongs
% %     to by looking at its file name. This is used for precision and recall
% %     calculations.
% % 
% % INPUT:
% %     filename: Name of image file
% % RETURN:
% %     img_category: Number representing category of image. 

split_filename = split(filename,'_');
img_category = str2double(split_filename(1));

return
