%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotRkt.m
%
% Overview:
%  Plot selected variables in the rocket model output file.
%
% Usage:
%  plotRkt(dat);
%
%  dat is a structure of vectors generated from the rocket model output file
%  using:
%
%    [dat] = loadDataFile('rocket.txt');
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
function plotRkt(dat)

  gee = 9.81;

  getFig('plotRkt 1');

    pos = 1;
      subplot(2,2,pos);
      hold on;

      plot(dat.time, dat.pos*1e-3, 'b', 'linewidth', 2);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Position (km)');
      title('Altitude');

    % end axis

    pos = 2;
      subplot(2,2,pos);
      hold on;

      plot(dat.time, dat.vel*1e-3, 'b', 'linewidth', 2);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Velocity (km/sesc)');
      title('Velocity');

    % end axis

    pos = 3;
      subplot(2,2,pos);
      hold on;

      plot(dat.time, dat.acc/gee, 'b', 'linewidth', 2);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Acceleration (gees)');
      title('Acceleration');

    % end axis

    pos = 4;
      subplot(2,2,pos);
      hold on;

      plot(dat.time, dat.mass, 'b', 'linewidth', 2);

      set(gca, 'box', 'on');
      ylim([0,500]);
      grid on;
      xlabel('Time (sec)');
      ylabel('Mass (kg)');
      title('Total Mass');

    % end axis

  % end figure

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
