%% New script EEG

% Limpiar entorno
close all;
clear all; clc

% Open folder
%%%%% Change folder
cfg = []; 
cfg.dir = ['C:\Users\yangy\Desktop\PPD\eeg']; 

% Import data
%%%%% Change route and name of eeg data
EEG = pop_biosig('C:\Users\yangy\Desktop\PPD\eeg\eeg_raw_data\', 'importannot','off');
eeglab redraw; 


%% Automated Pipeline
% Select channels
EEG = pop_select( EEG, 'channel',{'Cz','Fz','Fp1','F7','F3','FC1','C3','FC5','FT9','T7','CP5','CP1','P3','P7','PO9','O1','Pz','Oz','O2','PO10','P8','P4','CP2','CP6','T8','FT10','FC6','C4','FC2','F4','F8','Fp2','MarkerValueInt'});
eeglab redraw; 

% Event channel
EEG = pop_chanevent(EEG, 33,'edge','leading','edgelen',0);
eeglab redraw; 

% Delete participants answers
EEG.urevent = EEG.urevent([EEG.urevent.type] > 10);
EEG.event = EEG.event([EEG.event.type] > 10);

% Channel locations
EEG=pop_chanedit(EEG, {'lookup','standard_1005.elc'});
eeglab redraw; 

%Resample data
EEG = pop_resample( EEG, 128);
eeglab redraw; 

% Re-reference the data
EEG = pop_reref( EEG, []);
eeglab redraw; 

% Filtering
EEG  = pop_basicfilter( EEG,  1:32 , 'Boundary', 'boundary', 'Cutoff', [ 0.5 35], 'Design', 'butter', 'Filter', 'bandpass', 'Order',  2, 'RemoveDC', 'on' ); % GUI: 26-Sep-2024 19:35:13
eeglab redraw; 


%% Behavioral Data

% Import data
%%%%% Change data name
data = readtable('C:\Users\yangy\Desktop\PPD\eeg\beh_data\');

% Delete extra data
data(241:256, :) = [];

% Change data of EEG.urevent
for i = 1:length(EEG.urevent)
    if data.key_resp_training_corr(i) == 1
        EEG.urevent(i).type = 111;
    elseif data.key_resp_training_corr(i) == 0
        EEG.urevent(i).type = 112;
    end
end


% Change data of EEG.event
for i = 1:length(EEG.event)
    if data.key_resp_training_corr(i) == 1
        EEG.event(i).type = 111;
    elseif data.key_resp_training_corr(i) == 0
        EEG.event(i).type = 112;
    end
end


% Change data of EEG.urevent (blocks)
for i = 1:length(EEG.urevent)
    current_type = EEG.urevent(i).type;  % Ya debería ser un número como 111 o 112
    if i <= 80
        EEG.urevent(i).type = current_type * 10 + 1;  % Agregar un 1 al final
    elseif i <= 160
        EEG.urevent(i).type = current_type * 10 + 2;  % Agregar un 2 al final
    elseif i <= 240
        EEG.urevent(i).type = current_type * 10 + 3;  % Agregar un 3 al final
    end
end


% Change data of EEG.event (blocks)
for i = 1:length(EEG.event)
    current_type = EEG.event(i).type;  % Ya debería ser un número como 111 o 112
    if i <= 80
        EEG.event(i).type = current_type * 10 + 1;  % Agregar un 1 al final
    elseif i <= 160
        EEG.event(i).type = current_type * 10 + 2;  % Agregar un 2 al final
    elseif i <= 240
        EEG.event(i).type = current_type * 10 + 3;  % Agregar un 3 al final
    end
end


%% Limpieza

% PLOT (check channels)
pop_eegplot( EEG, 1, 1, 1);

% Interpolate channel
EEG = pop_interp(EEG, [], 'spherical'); % Change [] number

% Reject bad data
EEG = eeg_eegrej( EEG, []);

% ICA
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on','pca',32);

% Remove artifacts
EEG = pop_subcomp( EEG, [], 0);

% SAVE DATASET
% EEG = pop_saveset( EEG, 'filename','S_13_C90.set','filepath','C:\\Users\\yangy\\Desktop\\PPD\\eeg\\eeg_filtered_data\\');
