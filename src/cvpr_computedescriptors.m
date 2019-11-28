%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_computedescriptors.m
%% Skeleton code provided as part of the coursework assessment
%% This code will iterate through every image in the MSRCv2 dataset
%% and call a function 'extractRandom' to extract a descriptor from the
%% image.  Currently that function returns just a random vector so should
%% be changed as part of the coursework exercise.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '/Users/nathanstrickland/Documents/Uni Work/EEE3032_CVP/Assignment/MSRC_ObjCategImageDatabase_v2';



% % Change DESCRIPTOR_NUM to determine which image descriptor to calculate
% % Global Colour Histogram: 0 || Spatial Grid Color: 1 || 
% % Spatial Grid Texture: 2    || Spatial Grid Color & Textures: 3 ||
DESCRIPTOR_NUM = 1; 

% % Global Colour Histogram Parameters
GCH_QUANTISATION = 8;

% % Spatial Grid Color, Texture & Both Parameters
GRID_ROWS = 10;
GRID_COLS = 10;
EOH_QUANTISATION = 2;
EOH_THRESHOLD = 0.15;

%% Create a folder to hold the results...
OUT_FOLDER = '/Users/nathanstrickland/Documents/Uni Work/EEE3032_CVP/Assignment/descriptors';
%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
switch DESCRIPTOR_NUM
    case 0
        OUT_SUBFOLDER ='globalRGBhisto';
    case 1
        OUT_SUBFOLDER ='gridColor';
    case 2
        OUT_SUBFOLDER ='gridEOH';
    case 3
        OUT_SUBFOLDER ='gridColorEOH';
end

allfiles = dir(fullfile([DATASET_FOLDER, '/Images/*.bmp']));
for filenum = 1:length(allfiles)
    fname = allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n', filenum,length(allfiles), fname);
    tic;
    imgfname_full = ([DATASET_FOLDER,'/Images/', fname]);
    img = double(imread(imgfname_full))./255;
    fout = [OUT_FOLDER, '/', OUT_SUBFOLDER, '/', fname(1:end-4), '.mat']; %replace .bmp with .mat
    switch DESCRIPTOR_NUM
        case 0
            F = cvpr_extract_GCH(img, GCH_QUANTISATION);
        case 1
            F = cvpr_extract_color(img, GRID_ROWS, GRID_COLS);
        case 2
            F = cvpr_extract_EOH(img, GRID_ROWS, GRID_COLS, EOH_THRESHOLD, EOH_QUANTISATION);
        case 3
            F = cvpr_extract_EOHColor(img, GRID_ROWS, GRID_COLS, EOH_THRESHOLD, EOH_QUANTISATION);
    end
    save(fout, 'F');
    toc
end
