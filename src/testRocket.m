%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% testRocket.m
%
% Overview:
%  Script to test the rocket model.
%
% Usage:
%  testRocket;
%
%  Output is written to an ascii file named rocket.txt suitable for reading
%  into the workspace with loadDataFile:
%
%  [dat] = loadDataFile('rocket.txt');
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
function testRocket

  dt = 1.0e-3;
  time = 0.0;
  stopTime = 30.0;
  datRkt = struct();

  fp = fopen('rocket.txt', 'w');

  firstPass = true;
  while ((time + dt <= stopTime))

    if (time - floor(time) < dt)
      fprintf('%5.1f ', time);
      if (mod(time, 10) < 0.5)
        fprintf('\n');
      end;
      fflush(stdout);
    end;

    [datRkt] = rocket(datRkt, time, dt);

    fields = fieldnames(datRkt);

    if (firstPass)
      firstPass = false;
      fprintf(fp, '%-15s ', 'time'); 
      for (idx = 1:length(fields))
        fprintf(fp, '%-15s ', fields{idx});
      end;
      fprintf(fp, '\n');
    end;

    fprintf(fp, '%-15.6e ', time); 
    for (idx = 1:length(fields))
      fprintf(fp, '%-15.6e ', datRkt.(fields{idx}));
    end;
    fprintf(fp, '\n');

    time = time + dt;
  end;

  fclose(fp);

  fprintf('%5.1f \n', time);
  fflush(stdout);

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
