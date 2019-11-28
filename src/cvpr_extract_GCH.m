function F=cvpr_extract_GCH(img, Q)
% % cvpr_extract_extractGCH
% %     This function calculates the global colour histogram (GCH) of a
% %     normalised image for a given quantisation level. The image
% %     descriptor is a normalised histogram.
% % 
% % INPUT:
% %     img: normalised vector representing an image.
% %     Q: quantisation level.
% % RETURN:
% %     F: Feature vector representing the image

r = img(:, :, 1);
g = img(:, :, 2);
b = img(:, :, 3);

rdash = floor(r.*Q);
gdash = floor(g.*Q);
bdash = floor(b.*Q);

bin = rdash*(Q^2) + gdash*(Q) + bdash;
vals = reshape(bin, 1, size(bin,1) * size(bin, 2));
H = hist(vals, Q^3);
F = H./sum(H);

return;