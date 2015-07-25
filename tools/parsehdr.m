% parsehdr.m
%
% Overview:
%
%   Read a line of text and parse it into a cell array of words assuming blanks
%   as delimiters.
%
% Usage:
%
%  nameArray = parshdr(hdr);
%
%    hdr       = line of words separated by blanks.
%
%    nameArray = cell array containing the words of hdr.
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
function nameArray = parsehdr(hdr);

  hdr = deblank(hdr);
  strLen = length(hdr);

  idx = 0;
  ptr = 0;
  while (~isempty(hdr))
    idx = idx + 1;
    [nameArray{idx, 1}, cnt, err, ptr] = sscanf(hdr, '%s', 1);
    hdr = hdr(ptr:end);
    strLen = length(hdr);
  end;

return;
