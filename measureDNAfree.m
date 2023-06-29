clearvars
clc

%reader = BioformatsImage('../data/Control_17MHz_100gain_60kframes_10ms_001.nd2');

I = rgb2gray(imread('D:\Work\ALMC\Ticket 17287 - Daniel Ocampo\data\Control_17MHz_100gain_60kframes_10ms_001 Reconstruction.tif'));

%%
%Filter and binarize the image
filteredI = filter2(fspecial('gaussian', [5 5], 2), I);

maskDNA = imbinarize(filteredI, 'adaptive', 'Sensitivity', 0.0001);
maskDNA = imopen(maskDNA, strel('disk', 4));

imshowpair(filteredI, maskDNA)
%%
se = strel('disk', 18);

filled = imdilate(maskDNA, se);
filled = imfill(filled, 'holes');
filled = imerode(filled, se);

imshowpair(filteredI, filled)

%%
%Measure percent of dark region
percentBlack = 100 - ((nnz(maskDNA) * 100)/nnz(filled));
