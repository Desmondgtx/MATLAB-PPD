%% BINS & EPOCHS

% Limpiar entorno
close all;
clear all; clc

% Open folder
cfg = []; 
cfg.dir = ['C:\Users\yangy\OneDrive\Escritorio\PPD\eeg']; 

% Load Data
EEG = pop_loadset('filename','S_02_A70.set','filepath','C:\\Users\\yangy\\Desktop\\PPD\\eeg\\Filtered Data\\');
eeglab redraw;

% Create Event List
EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' } ); 
eeglab redraw;

% Assign Bins
EEG  = pop_binlister( EEG , 'BDF', 'C:\Users\yangy\Desktop\PPD\eeg\bins.txt', 'IndexEL',  1, 'SendEL2', 'EEG', 'Voutput', 'EEG' ); 
eeglab redraw;

% Extract bin-based epochs
EEG = pop_epochbin( EEG , [-500.0  1500.0],  [ -200 -100]);
eeglab redraw;

% Save ERP data
ERP = pop_averager( EEG , 'Criterion', 'good', 'DQ_custom_wins', 0, 'DQ_flag', 1, 'DQ_preavg_txt', 0, 'ExcludeBoundary', 'on', 'SEM', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', 'S_02_A70', 'filename', 'S_02_A70.erp', 'filepath', 'C:\Users\yangy\Desktop\PPD\eeg\ERPs', 'Warning', 'on');% Change 'example' for the name of the ERP and then for the dataset (also the path lol)



%% FRN & Measurement Tools
% Import ERP Data
% ERP = pop_loaderp( 'filename', 'S_02_A70.erp', 'filepath', 'C:\Users\yangy\Desktop\PPD\eeg\ERPs\' );  Better to do it manually  

% Extract FRN Bin
ERP = pop_binoperator( ERP, {'b9 = b1 - b2 label FRN','b10 = b3 - b4 label FRN_1','b11 = b5 - b6 label FRN_2','b12 = b7 - b8 label FRN_3'});
eeglab redraw;

% Save Measurement Tool File
ALLERP = pop_geterpvalues( ERP, [ 200 350],9:12, [ 1 2 6 29] , 'Baseline', 'none', 'FileFormat', 'long', 'Filename', 'C:\Users\yangy\Desktop\PPD\eeg\Measurement tool\S_02_A70.xls', 'Fracreplace', 'NaN', 'InterpFactor',1, 'Measure', 'meanbl', 'PeakOnset',1, 'Resolution',3 );                                                  
