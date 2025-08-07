% Cargar los datos del ERP
% ERP = tu_archivo_erp; % Asegúrate de tener cargado tu archivo .erp

% Definir los bins y el intervalo de tiempo
bins_cond1 = [10, 11, 12];  % Condición 70%
bins_cond2 = [22, 23, 24];  % Condición 90%
time_window = [300 600];     % Ventana de tiempo en ms

% Definir los nombres de los bloques
bloques = {'Bloque 1', 'Bloque 2', 'Bloque 3'};

% Encontrar los índices de tiempo
[~, t1] = min(abs(ERP.times - time_window(1)));
[~, t2] = min(abs(ERP.times - time_window(2)));

% Crear la figura
figure('Position', [100 100 1200 600]);

% Graficar primera condición (fila superior) - Condición 70%
for i = 1:length(bins_cond1)
    subplot(2, 3, i);
    
    % Calcular el promedio en la ventana de tiempo
    data_mean = mean(ERP.bindata(:, t1:t2, bins_cond1(i)), 2);
    
    % Graficar el mapa topográfico
    topoplot(data_mean, ERP.chanlocs, ...
        'maplimits', 'maxmin', ...
        'colormap', jet, ...
        'electrodes', 'on', ...
        'style', 'both');
    
    % Título
    title(sprintf('%s - Condición 70%%', bloques{i}), ...
        'FontName', 'Helvetica', 'FontSize', 15);
    
    % Barra de color solo para el último de cada fila
    if i == 3
        colorbar;
    end
end

% Graficar segunda condición (fila inferior) - Condición 90%
for i = 1:length(bins_cond2)
    subplot(2, 3, i + 3);
    
    % Calcular el promedio en la ventana de tiempo
    data_mean = mean(ERP.bindata(:, t1:t2, bins_cond2(i)), 2);
    
    % Graficar el mapa topográfico
    topoplot(data_mean, ERP.chanlocs, ...
        'maplimits', 'maxmin', ...
        'colormap', jet, ...
        'electrodes', 'on', ...
        'style', 'both');
    
    % Título
    title(sprintf('%s - Condición 90%%', bloques{i}), ...
        'FontName', 'Helvetica', 'FontSize', 15);
    
    % Barra de color solo para el último de cada fila
    if i == 3
        colorbar;
    end
end





ERP = pop_ploterps( ERP,  3:5,  33:40 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 4 2], 'ChLabel',...
 'on', 'FontSizeChan',  15, 'FontSizeLeg',  15, 'FontSizeTicks',  15, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  1,...
 'Maximize', 'on', 'Position', [ 103.714 28 106.857 31.9412], 'SEM', 'on', 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0.7,...
 'xscale', [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );








% Ejecuta tu código original
ERP = pop_scalplot( ERP,  3:5, [ -200 798] , 'Blc', 'pre', 'Colormap', 'viridis', ...
    'Electrodes', 'on', 'FontName', 'Courier New', 'FontSize', 10, ...
    'Legend', 'bn-la', 'Maplimit', 'maxmin', 'Mapstyle', 'map', ...
    'Maptype', '3D', 'Mapview', 'back', 'Plotrad',  0.55, ...
    'Splinefile', 'C:\Users\yangy\Desktop\Listos\Mona Lisa EEG\spline', ...
    'Value', 'mean' );

% Obtén el handle de la figura actual
fig = gcf;

% Obtén todos los axes (subplots) de la figura
ax = findobj(fig, 'Type', 'axes');

% Reorganiza los subplots horizontalmente
n_plots = length(ax);
for i = 1:n_plots
    subplot(1, n_plots, n_plots-i+1, ax(i));
end

% Ajusta el tamaño de la figura para acomodar el layout horizontal
set(fig, 'Position', [100, 100, 400*n_plots, 400]);










% Ejecuta tu código original
ERP = pop_scalplot( ERP,  3:5, [ -200 798] , 'Blc', 'pre', 'Colormap', 'viridis', ...
    'Electrodes', 'on', 'FontName', 'Courier New', 'FontSize', 10, ...
    'Legend', 'bn-la', 'Maplimit', 'maxmin', 'Mapstyle', 'map', ...
    'Maptype', '3D', 'Mapview', 'back', 'Plotrad',  0.55, ...
    'Splinefile', 'C:\Users\yangy\Desktop\Listos\Mona Lisa EEG\spline', ...
    'Value', 'mean' );

% Obtén el handle de la figura actual
fig = gcf;

% Elimina las barras de color antes de reorganizar
delete(findall(fig, 'type', 'colorbar'));

% Obtén todos los axes (subplots) de la figura (después de eliminar colorbars)
ax = findobj(fig, 'Type', 'axes');

% Define los títulos para cada bin
titulos = {'Valencia Negativa', 'Valencia Neutra', 'Valencia Positiva'};

% Reorganiza los subplots horizontalmente y añade títulos
n_plots = length(ax);
for i = 1:n_plots
    subplot(1, n_plots, n_plots-i+1, ax(i));
    % Añade el título correspondiente a cada subplot
    title(ax(i), titulos{i}, 'FontSize', 12, 'FontWeight', 'bold');
end

% Ajusta el tamaño de la figura para acomodar el layout horizontal
set(fig, 'Position', [100, 100, 400*n_plots, 400]);