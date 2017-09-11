% Loads proportion of shots made that were 1/2/3's from 2008-2012
% Variables are named proportion2008 ... proportion2012
load League_Shot_Proportions

%% Proportion/percentage of made 1, 2 and 3 point shots made for each season
% Code reshapes the 48 by 3 into a 1 2 ... 12
%                                  36 ...  48 to be used for cycle plot.
%
% Ex: prop2008_3 <- represents percentage of shots made that were 3 point
%                   shots in that particular minute (variable contains 48
%                   minutes of percentages)
% 2008 season
prop2008_1 = flipud(proportion2008(:,1));
prop2008_1 = reshape(prop2008_1, [12 4]);
prop2008_1 = prop2008_1';

prop2008_2 = flipud(proportion2008(:,2));
prop2008_2 = reshape(prop2008_2, [12 4]);
prop2008_2 = prop2008_2';

prop2008_3 = flipud(proportion2008(:,3));
prop2008_3 = reshape(prop2008_3, [12 4]);
prop2008_3 = prop2008_3';

% 2009 season
prop2009_1 = flipud(proportion2009(:,1));
prop2009_1 = reshape(prop2009_1, [12 4]);
prop2009_1 = prop2009_1';

prop2009_2 = flipud(proportion2009(:,2));
prop2009_2 = reshape(prop2009_2, [12 4]);
prop2009_2 = prop2009_2';

prop2009_3 = flipud(proportion2009(:,3));
prop2009_3 = reshape(prop2009_3, [12 4]);
prop2009_3 = prop2009_3';

% 2010 season
prop2010_1 = flipud(proportion2010(:,1));
prop2010_1 = reshape(prop2010_1, [12 4]);
prop2010_1 = prop2010_1';

prop2010_2 = flipud(proportion2010(:,2));
prop2010_2 = reshape(prop2010_2, [12 4]);
prop2010_2 = prop2010_2';

prop2010_3 = flipud(proportion2010(:,3));
prop2010_3 = reshape(prop2010_3, [12 4]);
prop2010_3 = prop2010_3';

% 2011 season
prop2011_1 = flipud(proportion2011(:,1));
prop2011_1 = reshape(prop2011_1, [12 4]);
prop2011_1 = prop2011_1';

prop2011_2 = flipud(proportion2011(:,2));
prop2011_2 = reshape(prop2011_2, [12 4]);
prop2011_2 = prop2011_2';

prop2011_3 = flipud(proportion2011(:,3));
prop2011_3 = reshape(prop2011_3, [12 4]);
prop2011_3 = prop2011_3';

% 2012 season (lockout)
prop2012_1 = flipud(proportion2012(:,1));
prop2012_1 = reshape(prop2012_1, [12 4]);
prop2012_1 = prop2012_1';

prop2012_2 = flipud(proportion2012(:,2));
prop2012_2 = reshape(prop2012_2, [12 4]);
prop2012_2 = prop2012_2';

prop2012_3 = flipud(proportion2012(:,3));
prop2012_3 = reshape(prop2012_3, [12 4]);
prop2012_3 = prop2012_3';

%% free throw rate (2008-2012), adjusted for games
ft_rate = ((82 * prop2008_1) + (82 * prop2009_1) + (82 * prop2010_1) + (82 * prop2011_1) + (66 * prop2012_1))/(82+82+82+82+66);

%% two and three point rates (2008-2012), adjusted for games
two_rate = ((82 * prop2008_2) + (82 * prop2009_2) + (82 * prop2010_2) + (82 * prop2011_2) + (66 * prop2012_2))/(82+82+82+82+66);
three_rate = ((82 * prop2008_3) + (82 * prop2009_3) + (82 * prop2010_3) + (82 * prop2011_3) + (66 * prop2012_3))/(82+82+82+82+66);
