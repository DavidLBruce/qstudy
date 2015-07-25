%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% saveFigs.m
%
% Overview:
%  Saves selected figures to a folder in .fig format.
%
% Usage:
%  saveFigs(figVec, 'path/to/figure/folder/baseName');
%
%  If the path to the figure folder does not exist it will be created.  Figure
%  file names will be baseName_XX.fig, where xx is the figure number.
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
function saveFigs(figvec, figname)

  DIR = 7;

  idxDelim = sort([findstr(figname,'/'), findstr(figname,'\')]);
  if (~isempty(idxDelim))
    % Create directories, if necessary
    if (exist(figname(1:idxDelim(end))) ~= DIR)
      if (idxDelim(1) == 1) 
        % Absolute path
        idxDelim = idxDelim(2:end);
      end;
      for (idx = idxDelim)
        dirstr = figname(1:idx);
        if (~exist(dirstr, 'dir'))
          disp(['Making directory:  ', dirstr]);
          mkdir(dirstr);
        end;
      end;
    end;
  end;

  for (fig = figvec)
    tag = get(fig, 'tag');
    set(fig, 'tag','');
    savestr = [figname, '_',sprintf('%02d',fig), '.fig'];
    disp(savestr);
    saveas(fig,savestr);
    set(fig, 'tag',tag);
    pause(1);
  end;


return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
