% listPath.m
%
% array = listPath(disp_qty)
%
% Returns an nx1 cell array containing the directories on the path.
%
% If disp_qty provided, displays first disp_qty directories.
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

