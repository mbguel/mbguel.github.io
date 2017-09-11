%% Plot proportion of 1, 2, and 3 point shot mades, as a function
% v2 plots by both home and away team (SEASONAL, all teams)

clear;
close all;

%% User input
timeGap = 60; % Using bin size of 1 minute intervals.

%% Load data
load BasketBallData2008 d

%% Set boundaries
binEdges   = 0:timeGap:2880; % Creating the time vector in increments of time gap. (Say 60 seconds)
binCenters = timeGap/2:timeGap:(2880-timeGap/2);% To account for the extra bin created,
                                                % strictly for plotting. 
                                                % (e.g. it takes 3 lines to make two sections)
nBins      = length(binCenters); % Number of bins to be used for plotting.
nGames     = length(d); % Number of games

%% Count how many shots of each type in each bin
count = zeros(nBins, 6); % Matrix of number of time gaps (say 48 minutes so 48 gaps/rows), 
                         % separated into 3 columns for 1's/2's/3's.
                         
for bin = 1:nBins % For the total number of binCenters' increments
    for game = 1:nGames % Looping over all seasonal games;
        % match - looks for time scored if it is greater than [bin]'th time
        % & less than the next [bin]'th index, so it won't double count.
        % EX: First minute of game: time > binEdges(1) = 0 and less than the next index (60 sec.)
        matchHome = find([d(game).time] > binEdges(bin) & [d(game).time] <= binEdges(bin+1) & [d(game).scoringTeam] == 2);
        matchAway = find([d(game).time] > binEdges(bin) & [d(game).time] <= binEdges(bin+1) & [d(game).scoringTeam] == 1);
        count(bin, 1) = count(bin, 1) + length(find([d(game).scoringType(matchHome)] == 1));
        count(bin, 2) = count(bin, 2) + length(find([d(game).scoringType(matchHome)] == 2));
        count(bin, 3) = count(bin, 3) + length(find([d(game).scoringType(matchHome)] == 3));
        count(bin, 4) = count(bin, 4) + length(find([d(game).scoringType(matchAway)] == 1));
        count(bin, 5) = count(bin, 5) + length(find([d(game).scoringType(matchAway)] == 2));
        count(bin, 6) = count(bin, 6) + length(find([d(game).scoringType(matchAway)] == 3));
        % Count - will fill out the bin'th row (ex. 1st-48th minute), then
        % add number of made 1's/2's/3's to the matrix. So if three 2
        % pointers are made in the first minute, length of that would be
        % three.
        % So for the second minute, it would add three 2 pointers made +
        % the number of 3 pointers made in the second minute.
        
        % The outer loop will run 48 times, to represent the 48 minutes in
        % a game. Inner loop will run 978 times (total number of games).
        % It will look through all 978 games' shots made in the 1st minute,
        % then loop back over again (index is bin) for the 2nd minute, 3rd minute.
    end;
end;

% convert to proportions
proportion = zeros(nBins, 6); % Creates a matrix of nBins x 3. (e.g. 48 [min] x 3)
totalHome = sum(count(:, 1:3), 2);
totalAway = sum(count(:, 4:6), 2);

for bin = 1:nBins % It will loop over total number of bins (so ex. 48 minutes)
    proportionHome(bin, 1:3) = count(bin, 1:3)/totalHome(bin);
    proportionAway(bin, 1:3) = count(bin, 4:6)/totalAway(bin);
    % Proportion will divide each shot type made (1/2/3's) by total number
    % of shots taken in that minute. 
    % (So get something like 0.55/0.20/0.25)
    % But then it will repeat (bin is index, so it will go to the next
    % minute, then divide across the row)
   
end;

%% Plot the results

% Figure
F = figure(1); clf; hold on;
set(F, ...
    'color'             ,                    'w' , ...
    'units'             ,           'normalized' , ...
    'position'          ,          [.1 .1 .8 .8] , ...
    'paperpositionmode' ,                 'auto' );
        
% axes
subplot(1, 2, 1); cla; hold on;
set(gca, ...
    'xlim'              ,               [0 2880] , ...
    'xdir'              ,              'reverse' , ...
    'xtick'             ,      [0 720 1440 2160] , ...
    'xticklabel'        , {'F', '3Q', 'H', '1Q'} , ...
    'xgrid'             ,                   'on' , ...
    'ygrid'             ,                   'on' , ...
    'ylim'              ,               [0 1.01] , ...
    'ytick'             ,              0.2:0.1:1 , ...
    'box'               ,                  'off' , ...
    'tickdir'           ,                  'out' , ...
    'ticklength'        ,               [0.01 0] , ...
    'fontsize'          ,                    12 );
        
% labels, for the bottom-left plot
xlabel('Time'   , 'fontsize' , 16);
ylabel('Proportion of Made Shots' , 'fontsize' , 16);
title('Home Team', 'fontsize', 16, 'fontweight', 'normal');

% plot
H(1) = plot(binCenters, proportionHome(:, 1), 'ko-', ...
    'markerfacecolor', 'r');
H(2) = plot(binCenters, proportionHome(:, 2), 'ko-', ...
    'markerfacecolor', 'g');

H(3) = plot(binCenters, proportionHome(:, 3), 'ko-', ...
    'markerfacecolor', 'b');

% tidy
set(H, ...
    'linewidth'       , 1    , ...
    'markersize'      , 8   , ...
    'markeredgecolor' , 'w'  );

% legend
L = legend(H, {'1 point', '2 point', '3 point'});
set(L, ...
    'location' , 'northeast' , ...
    'box'      ,              'off' , ...
    'fontsize' , 14);

% axes
subplot(1, 2, 2); cla; hold on;
set(gca, ...
    'xlim'              ,               [0 2880] , ...
    'xdir'              ,              'reverse' , ...
    'xtick'             ,      [0 720 1440 2160] , ...
    'xticklabel'        , {'F', '3Q', 'H', '1Q'} , ...
    'xgrid'             ,                   'on' , ...
    'ygrid'             ,                   'on' , ...
    'ylim'              ,               [0 1.01] , ...
    'ytick'             ,              0.2:0.1:1 , ...
    'box'               ,                  'off' , ...
    'tickdir'           ,                  'out' , ...
    'ticklength'        ,               [0.01 0] , ...
    'fontsize'          ,                    12 );
        
% labels, for the bottom-left plot
xlabel('Time'   , 'fontsize' , 16);
ylabel('Proportion of Made Shots' , 'fontsize' , 16);
title('Away Team', 'fontsize', 16, 'fontweight', 'normal');

% plot
H(1) = plot(binCenters, proportionAway(:, 1), 'ko-', ...
    'markerfacecolor', 'r');
H(2) = plot(binCenters, proportionAway(:, 2), 'ko-', ...
    'markerfacecolor', 'g');

H(3) = plot(binCenters, proportionAway(:, 3), 'ko-', ...
    'markerfacecolor', 'b');

% tidy
set(H, ...
    'linewidth'       , 1    , ...
    'markersize'      , 8   , ...
    'markeredgecolor' , 'w'  );

% print
suptitle('% of Made Shots (Home & Away): 2007-08 Season')
%print(['Home_Away_Made_Shots_Pct_2008.png'], '-dpng');