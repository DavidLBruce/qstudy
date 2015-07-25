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
