%% Item sales as a cycle Plot
% Based on Few (2009, Figures 7.50, 7.52)
clear;

%% Using Item sales plot from the book for NBA data.

%% Data
% the quarters/minutes data are in a variable x in a .mat MATLAB data file
% the days are in rows, and the weeks in columns
load Total_FT_Rate fts_2011; % loading FT rate data from the season.
x = fts_2011; % this is the 2010-11 NBA season FT data.
quarterLabel = {'Q1', 'Q2', 'Q3', 'Q4'};
% Constants
[nQuarters, nMinutes] = size(x);
scale = 0.4; % drawing constant

%% Figure
figure(1); clf; hold on;
set(gcf, 'color', 'w', 'units', 'normalized', 'position', [.2 .1 .4 .8], 'paperpositionmode', 'auto');

% Axes for top panel (time series plot)
subplot(2,1,1); cla; hold on;
set(gca, 'xtick', [1 12 24 36 48], 'ytick', 0.2:0.2:1, ...
   'tickdir', 'out', 'fontsize', 14);
axis([0 nQuarters*nMinutes+1 0 1]);

%% Labels
xlabel('Game Time', 'fontsize', 16);
T = ylabel({'Pct', 'Shots'}, 'fontsize', 16);
set(T, 'rotation', 0, 'horizontalalignment', 'right');

%% Line
% Reshape "flattens out" the matrix x into a vector with 1 row and as many 
% columns as needed for the entries of x, 
% so it is just the time points
H = plot(1:nQuarters*nMinutes, reshape(x', 1, []), 'ko-');
set(H, 'markerfacecolor', 'w');

%% Axes for bottom panel (cycle plot)
subplot(2, 1, 2); cla; hold on;
set(gca, 'xtick', 1:nQuarters, 'xticklabel', quarterLabel, 'ytick', 0.2:0.2:1, ...
   'tickdir', 'out', 'fontsize', 14);
axis([0.5 nQuarters+0.5 0 1]);

%% Labels
xlabel('Game Time', 'fontsize', 16);
T = ylabel({'Pct', 'Shots'}, 'fontsize', 16);
set(T, 'rotation', 0, 'horizontalalignment',' right');

%% Lines
for i = 1:nQuarters
    H = plot(i-scale:(2*scale)/(nMinutes-1):i+scale, x(i, :), 'ko-');
    set(H,'color', [0.3 0.3 0.3], 'markerfacecolor', 'k', 'markersize', 4);
    H = plot(i+[-scale scale], [mean(x(i, :)) mean(x(i, :))], 'k-');
    set(H, 'linewidth', 2);
end;


%% Print
%suptitle('2010-11 NBA FT Proportions Per Minute')
%print('FT_Rate_2010-11.png', '-dpng', '-r300');