%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main.m
%
% Overview:
%  Executive script to run the UKF and rocket model.
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
function main

  %
  % Random number seed (state)
  %
  rndState = primes(5e5);
  rndState = rndState(1:625);

  rand('state', rndState);

  %
  % Simulation parameters
  %
  dt = 1.0e-3;
  time = 0.0;
  stopTime = 30.0;

  %
  % Store model parameters in structures between calls.
  %
  datRkt = struct();
  datUkf = struct();

  %
  % Position measurement variance
  %
  datUkf.RR = 1.0;

  %
  % Burnout detection flag
  %
  boDet = false;

  %
  % Sensor & KF frame interval
  %
  frameDt = 2.0e-2;
  frameTime = 0.0;

  rktFp = fopen('rocket.txt', 'w');
  ukfFp = fopen('ukf.txt', 'w');

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

    if (time >= frameTime)

      datUkf.ZZ(1,1) = datRkt.pos + sqrt(datUkf.RR(1,1)) * randn(1,1);

      [datUkf] = QstudyRktUKF(datUkf, time, frameDt);

    end;

    if (firstPass)
      %
      % Print output file column header.
      %
      firstPass = false;

      rktFields = fieldnames(datRkt);
      ukfFields = fieldnames(datUkf);

      fprintf(rktFp, '%-15s ', 'time'); 
      for (idx = 1:length(rktFields))
        fprintf(rktFp, '%-15s ', rktFields{idx});
      end;
      fprintf(rktFp, '\n');

      fprintf(ukfFp,  '%15s ', 'time');
      for (idx = 1:length(ukfFields))
        if (numel(datUkf.(ukfFields{idx})) == 1)
          fprintf(ukfFp, '%15s ', ukfFields{idx});
        else
          for (elemIdx = 1:numel(datUkf.(ukfFields{idx})))
            fprintf(ukfFp, '%13s%02d ', ukfFields{idx}, elemIdx);
          end;
        end;
      end;
      fprintf(ukfFp, '\n');
    end;

    fprintf(rktFp, '%-15.6e ', time);
    for (idx = 1:length(rktFields))
      fprintf(rktFp, '%-15.6e ', datRkt.(rktFields{idx}));
    end;
    fprintf(rktFp, '\n');
    fflush(rktFp);

    if (time >= frameTime)

      fprintf(ukfFp, '%15.6e ', time);
      for (idx = 1:length(ukfFields)) 
        fprintf(ukfFp, '%15.6e ', datUkf.(ukfFields{idx})');
      end;
      fprintf(ukfFp, '\n');
      fflush(ukfFp);

      frameTime = frameTime + frameDt;
    end;

    time = time + dt;

  end;

  fclose(rktFp);
  fclose(ukfFp);

  fprintf('%5.1f \n', time);
  fflush(stdout);

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
