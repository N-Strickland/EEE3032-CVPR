function [FCPA, vct, val] = cvpr_pca(F)
% % cvpr_pca
% % TO DO TO DO TO DO
% % 
% % INPUT:
% %     filename: Name of image file
% % RETURN:
% %     img_category: Number representing category of image. 
org = mean(F')';

Fsub = F - repmat(org, 1, size(F, 2));
C = (Fsub*Fsub')./size(F, 2);
disp(size(C))

[vct, val] = eig(C);

val(val==0) = [];
val = sort(val, 'descend')';

retainedEnergy = sum(abs(val))*0.95;
currentEnergy = 0;

for rank = 1:size(val,1)
    currentEnergy = sum(val(1:rank, 1));
    if (currentEnergy < retainedEnergy) continue;
    else break;
    end
end

val = val(1:rank);
vct = fliplr(vct);
vct = vct(:, 1:rank);

FCPA = vct'*Fsub;

return;