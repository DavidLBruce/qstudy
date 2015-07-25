% Classification:  UNCLASSIFIED
%
% Name:  curfigs.m
%
% Overview:
%  Returns the handles for all open figures in a row vector.
%
% Usage:
% 
%   figs = clr_figs();
%
% Restrictions / Concerns:
%  None.
%
% Author:
%  David Bruce  11/07/02
%
% Revisions:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% qstudy project
% Copyright (C) 2015  David L. Bruce
%                     CatalinaArts@gmail.com
#                     2000 S. Melrose Dr
#                     Vista, CA 92081      
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function figs = curfigs();

  figs = get(0,'children'); % Column vector
  figs = sort(figs)';       % Row vector

return;
