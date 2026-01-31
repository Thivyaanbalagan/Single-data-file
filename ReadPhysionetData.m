

% Download all data and keep it a single folder named "1. PAF_Database"

clc;clear all; close all;

% Navigate to the directory
cd '1. PAF_Database\'

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
