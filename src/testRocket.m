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
