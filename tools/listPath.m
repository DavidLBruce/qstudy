% listPath.m
%
% array = listPath(disp_qty)
%
% Returns an nx1 cell array containing the directories on the path.
%
% If disp_qty provided, displays first disp_qty directories.
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
function array = listPath(disp_qty);

  if (strcmp(computer, 'PCWIN'))
    delim = ';';  % dos 
  else
    delim = ':';  % linux 
  end;

  path_str = path;

  delim_idx = findstr(path_str, delim);

  start_idx = [1, delim_idx+1];

  end_idx = [delim_idx-1, length(path_str)];

  qty_dirs = length(start_idx);

  for (row = 1:qty_dirs)
    array{row} = path_str(start_idx(row):end_idx(row));
  end;

  disp_array = [];
  if (nargin == 1)
    for (row = 1:disp_qty)
      disp_array = strvcat(disp_array,array{row});
    end;
    disp(disp_array);
  end;
  
return;

