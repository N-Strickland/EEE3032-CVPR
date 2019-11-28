function dst=cvpr_compare_l1norm(F1, F2)
% % cvpr_compare_l1norm
% %     This function calculates the l1 norm (manhattan distance) between
% %     two image descriptors F1, F2 and returns the result.
% % 
% % INPUT:
% %     F1: Feature vector representing the image descriptor of the query
% %     image.
% %     F2: Feature vector representing the image descriptor of the
% %     candidate image.
% % RETURN:
% %     dst: L1 norm/manhattan distance from query image to candidate image
% %     in the feature space. 

dst = sum(abs(F1 - F2));

return;
