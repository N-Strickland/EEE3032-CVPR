function dst=cvpr_compare_l2norm(F1, F2)
% % cvpr_compare_l2norm
% %     This function calculates the l2 norm (euclidian distance) between
% %     two image descriptors F1, F2 and returns the result.
% % 
% % INPUT:
% %     F1: Feature vector representing the image descriptor of the query
% %     image.
% %     F2: Feature vector representing the image descriptor of the
% %     candidate image.
% % RETURN:
% %     dst: L2 norm/euclidian distance from query image to candidate image
% %     in the feature space. 

dst = F1 - F2;
dst = dst.^2;
dst = sum(dst);
dst = sqrt(dst);

return;
