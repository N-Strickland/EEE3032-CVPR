function [precision, recall] = cvpr_compute_pr(RESULTS, NUM_PR_CALC)
% % cvpr_compute_pr
% %     This function computes the precision and recall for a given image
% %     descriptor and distance measure. The function also plots a
% %     precision recall graph and calculates the average precision.
% % 
% % INPUT:
% %     RESULTS: A matrix representing all the returned images, used to
% %     calculate the precision and recall by comparing relevant query returns.
% %     NUM_PR_CALC: Number of results to calcualte the precision & recall
% %     for. 
% % RETURN:
% %     precision: precision of the query (0-1)
% %     recall: recall of the query (0-1)

precision = [];
recall = [];

query_image_category = RESULTS(1, 3);
total_relevant = sum(RESULTS(:, 3) == query_image_category);

retrieved_relevant = 0;
for i = 1 : NUM_PR_CALC
   if RESULTS(i, 3) == query_image_category
         retrieved_relevant = retrieved_relevant + 1;
   end
   new_precision = retrieved_relevant / i;
   new_recall = retrieved_relevant / total_relevant;
   precision = [precision; new_precision];
   recall = [recall; new_recall];
end

average_precision = sum(precision.*(RESULTS(1:NUM_PR_CALC, 3) == query_image_category)) / total_relevant;

plot(recall, precision, '-ro' ,'LineWidth', 2);
title(['Average Precision: ', num2str(average_precision)])
xlabel('Recall')
ylabel('Precision')
ylim([0,1])
figure;

return
  


