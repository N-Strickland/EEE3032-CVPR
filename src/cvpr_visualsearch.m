%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '/Users/nathanstrickland/Documents/Uni Work/EEE3032_CVP/Assignment/MSRC_ObjCategImageDatabase_v2';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = '/Users/nathanstrickland/Documents/Uni Work/EEE3032_CVP/Assignment/descriptors';

%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER ='gridColor';

% % Change DISTANCE_MEASURE to determine which measure of distance to use
% % L1 Norm: 0 || L2 Norm:  1 || Mahalanobis (only with PCA): 2
DISTANCE_MEASURE=1;

% % Flag for using PCA - set to true to use
USE_PCA=true;

% % Change QUERY_IMG_INDEX to desired image class.
% % Trees: 369 || Flowers: 21 || Cows: 304 || 
% % Face: 482  || Planes: 435 || Sign: 61  ||

QUERY_IMG_INDEX = 369; 

%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)

ALLFEAT = [];
ALLFILES = cell(1,0);
ctr = 1;
allfiles = dir(fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum = 1:length(allfiles)
    fname = allfiles(filenum).name;
    imgfname_full = ([DATASET_FOLDER,'/Images/',fname]);
    img = double(imread(imgfname_full))./255;
    thesefeat = [];
    featfile = [DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat']; %replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr} = imgfname_full;
    ALLFEAT = [ALLFEAT ; F];
    ctr = ctr+1;
end

%% 2) Pick an image at random to be the query
NIMG = size(ALLFEAT,1);           % number of images in collection
queryimg = QUERY_IMG_INDEX;
%% 3) Compute the distance of image to the query
disp(size(ALLFEAT));
if USE_PCA==true
    [FCPA, vct, val] = cvpr_pca(ALLFEAT');
    ALLFEAT = FCPA';
end

dst = [];
for i = 1:NIMG
    candidate = ALLFEAT(i,:);
    candidate_category = cvpr_image_category(allfiles(i).name);
    query = ALLFEAT(queryimg, :);
    switch DISTANCE_MEASURE
        case 0
            thedst = cvpr_compare_l1norm(query, candidate);
        case 1
            thedst = cvpr_compare_l2norm(query, candidate);
        case 2
            thedst = cvpr_compare_mahalanobis(query, candidate, val');
    end
    dst =[dst; [thedst i candidate_category]];
end
dst = sortrows(dst,1);  % sort the results

%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW = 15;
NUM_PR_CALC = 15;
precision = cvpr_compute_pr(dst, NUM_PR_CALC);
dst = dst(1:SHOW, :);
outdisplay = [];
for i = 1:size(dst, 1)
   img = imread(ALLFILES{dst(i,2)});
   img = img(1:2:end, 1:2:end, :); % make image a quarter size
   img = img(1:81, :, :); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay = [outdisplay img];
end
imshow(outdisplay);

