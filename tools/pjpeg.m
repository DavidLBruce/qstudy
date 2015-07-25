% pjpeg.m
%
% Overview:
%  Sets orientation to portrait.  Prints the open figures specified 
%  in the input vector as color jpeg files.  The figure 
%  number will be appended to the fileBaseName.
%
% Usage:
%  
%  pjpeg(figVec, fileBaseName);
%
% Modified for Octave
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
function pjpeg(figVec, fileBaseName);

  for (ii=1:length(figVec))
    fig = figVec(ii);
    orient(fig, 'portrait');

    fileName = sprintf('%s_%02d', fileBaseName, fig);

    print(fig, fileName, '-djpeg');
    orient(fig, 'landscape');
  end;

return;


