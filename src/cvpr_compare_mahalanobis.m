function dst=cvpr_compare_mahalanobis(F1, F2, val)
% % cvpr_compare_mahalanobis
% %     This function calculates the mahalanoibs distance between
% %     two image descriptors F1, F2 and returns the result.
% % 
% % INPUT:
% %     F1: Feature vector representing the image descriptor of the query
% %     image.
% %     F2: Feature vector representing the image descriptor of the
% %     candidate image.
% %     val: Eigenvalue of the dimension reduced feature matrix using PCA
% % RETURN:
% %     dst: Mahalanobis distance from query image to candidate image
% %     in the feature space. 

dst = F1 - F2;
dst = dst.^2/val;
dst = sum(dst);
dst = sqrt(dst);

return;
