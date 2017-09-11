%% t-SNE representation of basketball players
clear;
close all;

%% Load data
if exist('NBAPlayers2017.mat', 'file')
    load NBAPlayers2017 d
else
    % parse from Excel
    % loads each column
    [~, d.firstName] = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'a2:a487');
    [~, d.lastName] = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'b2:b487');
    [~, d.fullName] = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'c2:c487');
    
    d.gamesPlayed = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'e2:e487');
    d.gamesStarted = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'f2:f487');
    d.minutes = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'g2:g487');
    [~, d.team] = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'd2:d487');
    
    d.performance = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'h2:am487');
    [~, d.performanceName] = xlsread('NBA Season Stats (By Player).xlsx', 'Master 1', 'h1:am1');
    
    
    save NBAPlayers2017 d
end;


%% Getting the player profile data
if exist('NBAProfiles2017.mat', 'file')
    load NBAProfiles2017 pr
else
    % parse from Excel the player profiles
    pr = xlsread('NBA Season Profile.xlsx', 'Profiles', 'd2:d487');
    save NBAProfiles2017 pr
end
%% Create z-scores for performance
d.zPerformance = nan(d.nPlayer, d.nPerformance);
for i = 1:d.nPerformance
    d.zPerformance(:, i) = (d.performance(:, i) - nanmean(d.performance(:, i)))/nanstd(d.performance(:, i));
end;
d.zPerformance(find(isnan(d.zPerformance))) = 0;

%% Modify d.zPerformance to only include certain measures

% standard measures: pts/reb/ast/stl/blk/TO/FG%/3P%/FT%
measures_std = d.zPerformance(:,[1,4:8,12,15,18]);

% Other experimental measures I used are on a separate Google sheet.

%% Player type numbers: [1 2 3 4 5 6 8 9] <- there is no 7.
% 1) non-factors
% 2) "star" playmaking players/primary scoring options
% 3) primary team ballhandlers (starters)
% 4) starting wings
% 5) secondary ballhandlers/guards
% 6) secondary wings
% 8) Starting? or Second unit bigmen
% 9) athletic or versatile or effective big men
playerType = [1 2 3 4 5 6 8 9];

% Setting colors for each player type:
% colors: 1) gray 2) purple 3) blue 4) green 5) navy 6) olive 8) lavender
% 9) pink
colorSet = [128 128 128; ...
          130 0 150; ...
          67 133 255; ...
          0 190 0; ...
          0 0 128; ...
          128 128 0; ...
          %255 150 0; ...
          230-100 190-100 255-100; ...
          255-50 200-50 220;]/255;
 
markerSet = [4 8 6 6 6 6 6 8]; % marker sizes for each type
%% mapping
mappedX = compute_mapping(measures_std, 'tSNE', 2);	
y = mappedX;

%% Plot
figure(1);clf; hold on;
set(gcf, 'color', 'w',         ...
    'units', 'normalized',     ...
    'position', [.1 .1 .8 .8]);
for i = 1:d.nPlayer
    
    if pr(i) == 1 % non-factors, made their names white.
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(1), ...
        'markerfacecolor', colorSet(1, :), ...
        'markeredgecolor', 'w'); 
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', 'w');%(1,:));
    z.FontSize = 4;
    
    
    elseif pr(i) == 2 % "star "playmaking players/primary scoring options
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(2), ... % larger marker for primary scoring options
        'markerfacecolor', colorSet(2, :), ...
        'markeredgecolor', 'w');
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', colorSet(2,:));
    z.FontSize = 7;
    
    
    elseif pr(i) == 3 % primary team ballhandlers (usually starting PGs)
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(3), ...
        'markerfacecolor', colorSet(3, :), ...
        'markeredgecolor', 'w');
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', colorSet(3,:));
    z.FontSize = 7;
    
    elseif pr(i) == 4 % starting wings
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(4), ...
        'markerfacecolor', colorSet(4, :), ...
        'markeredgecolor', 'w');
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', colorSet(4,:));
    z.FontSize = 7;
    
    elseif pr(i) == 5 % secondary ballhandlers/guards
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(5), ...
        'markerfacecolor', colorSet(5, :), ...
        'markeredgecolor', 'w');
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', colorSet(5,:));
    z.FontSize = 7;
    
    elseif pr(i) == 6 % secondary wings
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(6), ...
        'markerfacecolor', colorSet(6, :), ...
        'markeredgecolor', 'w');
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', colorSet(6,:));
    z.FontSize = 7;
    
    elseif pr(i) == 8 % starting or second unit bigmen
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(7), ...
        'markerfacecolor', colorSet(7, :), ...
        'markeredgecolor', 'w');
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', colorSet(7,:));
    z.FontSize = 7;
    
    elseif pr(i) == 9 % athletic or versatile or effective big men
    plot(y(i, 1), y(i, 2), 'ko', ...
        'markersize', markerSet(8), ...
        'markerfacecolor', colorSet(8, :), ...
        'markeredgecolor', 'w');
    z = text(y(i, 1), y(i, 2), [' ', d.lastName{i}], ...
        'verticalalignment', 'middle',           ...
        'color', colorSet(8,:));
    z.FontSize = 7;
        
    end  
end;
axis square;
axis equal
axis off;

fig = gcf; 
fig.PaperPositionMode = 'auto';
%suptitle('tSNE Clustering of 2016-17 NBA Players (Standard Measures)')
%print('tSNE_0603_Plot2.png', '-dpng', '-r300');