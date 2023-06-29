clearvars
clc

reader = BioformatsImage('../data/Control_17MHz_100gain_60kframes_10ms_001.nd2');

%%
I = getPlane(reader, 1, 1, 30);

filtI = imgaussfilt(I, 1);

%Apply a DoG
filt2 = imgaussfilt(I, 4);

dog = filt2 - filtI;

imshowpair(I, dog > 30);


