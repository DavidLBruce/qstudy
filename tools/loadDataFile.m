% loadDataFile.m
%
%  Overview:
%
%    Load a table of data into a structure of vectors.  The field names are
%    taken from the table column headers.  Each field is a vector of the 
%    corresponding column.
%    
%  Usage:
%
%    dat = loadDataFile(fileName);
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
function datStr = loadDataFile(fileName);

  fp = fopen(fileName);

  hdr = fgetl(fp);

  fieldNames = parsehdr(hdr);

  qtyCols = length(fieldNames);

  [datTbl, qtyDat] = fscanf(fp, '%f', inf);

  qtyRows = qtyDat / qtyCols;

  datTbl = reshape(datTbl, qtyCols, qtyRows)';

  for (col = 1:qtyCols)
    cmd = ['datStr.',fieldNames{col}, ' = datTbl(:,col);'];
    eval(cmd);
  end;

  fclose(fp);

return;
