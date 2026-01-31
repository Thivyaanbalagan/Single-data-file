% This script parses the data from the PhysioNet 2017 Challenge and saves
% the data into PhysionetData.mat for quick and easy future use.

% Copyright 2017 The MathWorks, Inc.

% Download and unzip the data, training2017.zip, from the PhysioNet website
% https://physionet.org/challenge/2017/
% unzip('https://archive.physionet.org/challenge/2017/training2017.zip')
clc;clear all; close all;

% Navigate to the directory
cd '--1. PAF_Database\'

% File with filenames and labels
ref = 'PAF_prediction';

% Create a table that contains the filenames and corresponding label data
tbl = readtable(ref,'ReadVariableNames',false);
tbl.Properties.VariableNames = {'Filename','Label'};

% Delete 'Other Rhythm' and 'Noisy Recording' signals
% toDelete = strcmp(tbl.Label,'O') | strcmp(tbl.Label,'~');
% tbl(toDelete,:) = [];

% Load each file in the table and store the corresponding signal data
H = height(tbl);
for ii = 1:H
    fileData = load([tbl.Filename{ii},'.mat']);
    tbl.Signal{ii} = fileData.val;
end

% Leave the training2017 directory
cd ..

% Format the data properly for LSTM training
% Signals: Cell array of predictors
% Labels: Categorical array of responses
Signals = tbl.Signal;
Labels = categorical(tbl.Label);

% Save the variables to a MAT-file
save PAF_new.mat Signals Labels
