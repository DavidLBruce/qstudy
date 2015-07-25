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
