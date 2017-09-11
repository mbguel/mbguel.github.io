clear;

% loads FT variables (variable names: fts_2008 ... fts_2012)
load NBA_FreeThrows
% free throw rate (2008-2012), adjusted for games
ft_rate = ((82 * fts_2008) + (82 * fts_2009) + (82 * fts_2010) + (82 * fts_2011) + (66 * fts_2012))/(82+82+82+82+66);