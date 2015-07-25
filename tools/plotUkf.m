%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotUkf.m
%
% Overview:
%  Plot selected variables in the rocket model output file.
%
% Usage:
%  plotUkf(datUkf);
%
%  datUkf is a structure of vectors generated from the rocket model output file
%  using:
%
%    [datUkf] = loadDataFile('ukf.txt');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function lh = plotUkf(datUkf, datRkt)

  gee = 9.81;

  idxs = find(datUkf.boDet);
  datUkf.PP16(idxs) = 0.0;

  getFig('plotUkf 1');

    pos = 1;
      subplot(2,2,pos);
      hold on;

      plot(datUkf.time, datUkf.Xkf01*1e-3, 'b', 'linewidth', 2);

      plot(datRkt.time, datRkt.pos*1e-3, 'r--', 'linewidth', 0.5);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Position (km)');
      title('Altitude; b=est; r=tru');

    % end axis

    pos = 2;
      subplot(2,2,pos);
      hold on;

      plot(datUkf.time, datUkf.Xkf02*1e-3, 'b', 'linewidth', 2);

      plot(datRkt.time, datRkt.vel*1e-3, 'r--', 'linewidth', 0.5);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Velocity (km/sesc)');
      title('Velocity');

    % end axis

    pos = 3;
      subplot(2,2,pos);
      hold on;

      plot(datUkf.time, datUkf.Xkf03/gee, 'b', 'linewidth', 2);

      plot(datRkt.time, datRkt.acc/gee, 'r--', 'linewidth', 0.5);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Acceleration (gees)');
      title('Acceleration');

    % end axis

    pos = 4;
      subplot(2,2,pos);
      hold on;

      plot(datUkf.time, datUkf.Xkf04, 'b', 'linewidth', 2);

      plot(datRkt.time, datRkt.mDotOvrM, 'r--', 'linewidth', 0.5);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('mDot/mass (sec^-1)');
      title('mDot/mass');

    % end axis

  % end figure

  getFig('plotUkf 2');

    pos = 1;
      subplot(2,2,pos);
      hold on;

      truth = interp1(datRkt.time, datRkt.pos, datUkf.time);

      error = datUkf.ZZ - truth;

      lh = plot(datUkf.time, error, 'g.', 'markersize', 2);

      error = datUkf.Xkf01 - truth;

      plot(datUkf.time, error, 'b', 'linewidth', 2);

      sig = sqrt(datUkf.PP01);

      plot(datUkf.time, sig, 'k.', 'markersize', 1.0);

      plot(datUkf.time, -sig, 'k.', 'markersize', 1.0);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Position Error, (m)');
      title('Altitude Error; b=est; g=meas; k=sig');

    % end axis

    pos = 2;
      subplot(2,2,pos);
      hold on;

      truth = interp1(datRkt.time, datRkt.vel, datUkf.time);

      error = datUkf.Xkf02 - truth;

      plot(datUkf.time, error, 'b', 'linewidth', 2);

      sig = sqrt(datUkf.PP06);

      plot(datUkf.time, sig, 'k.', 'markersize', 1.0);

      plot(datUkf.time, -sig, 'k.', 'markersize', 1.0);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Velocity Error, (m/sec)');
      title('Velocity Estimate Error');

    % end axis

    pos = 3;
      subplot(2,2,pos);
      hold on;

      truth = interp1(datRkt.time, datRkt.acc, datUkf.time);

      error = datUkf.Xkf03 - truth;

      plot(datUkf.time, error, 'b', 'linewidth', 2);

      sig = sqrt(datUkf.PP11);

      plot(datUkf.time, sig, 'k.', 'markersize', 1.0);

      plot(datUkf.time, -sig, 'k.', 'markersize', 1.0);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('Acceleration Error, (m/sec^2)');
      title('Acceleration Estimate Error');

    % end axis

    pos = 4;
      subplot(2,2,pos);
      hold on;

      truth = interp1(datRkt.time, datRkt.mDotOvrM, datUkf.time);

      error = datUkf.Xkf04 - truth;

      plot(datUkf.time, error, 'b', 'linewidth', 2);

      sig = sqrt(datUkf.PP16);

      plot(datUkf.time, sig, 'k.', 'markersize', 1.0);

      plot(datUkf.time, -sig, 'k.', 'markersize', 1.0);

      set(gca, 'box', 'on');
      grid on;
      xlabel('Time (sec)');
      ylabel('mDot/mass Error, (sec^1)');
      title('mDot/mass Estimate Error');

    % end axis

  % end figure

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
