%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QstudyRktUKF.m
%
% Overview:
%  This is the executive script implementing a 1-d scenario of a radar tracker
%  which tracks a boosting rocket.  Both the truth model and the Kalman Filter
%  dynamics model are nonlinear.
%
% Usage:
%  QstudyRktUKF(paramFile);
%
%    paramFile is the name of the script to set up the parameters for a case
%    study.  Do not include the .m extension.
%
%    Output is written to a text file called out.txt, which can be read into a 
%    structure by the utility function loadDataFile.m and plotted by plotKF.m
%   
%     [dat] = loadDataFile('out.txt');
%     plotRktKF(dat);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [datUkf] = QstudyRktUKF(datUkf, time, dt)

  SMALL = 1e-4;

  if (time < dt)
    %
    % Initialize variables
    %

    %
    % Continuous process noise matrix.  The position and velocity variances
    % are zero.  Just omit them from Q.
    %
    datUkf.Qacc = 0.1^2;
    datUkf.Qmdom = (1.0 / 300)^2;
    datUkf.QQ = diag([datUkf.Qacc, datUkf.Qmdom]);

    %
    % Kalman state vector
    % 
    datUkf.Xkf(1,1) = 0.0;     % Position
    datUkf.Xkf(2,1) = 0.0;     % Velocity
    datUkf.Xkf(3,1) = 9.81;    % Acceleration
    datUkf.Xkf(4,1) = -10/300; % Mass dot over mass

    %
    % Estimation covariance matrix
    %
    datUkf.PP = zeros(4,4);
    datUkf.PP(1,1) = datUkf.RR(1,1);
    datUkf.PP(2,2) = 1.0;
    datUkf.PP(3,3) = 5.0^2;
    datUkf.PP(4,4) = (10 / 300)^2;

    %
    % n (nn) is the length of the non augmented state vector.
    % N (NN) is the length of the augmented state vector.
    %
    datUkf.nn = length(datUkf.Xkf);
    datUkf.NN = datUkf.nn + length(datUkf.QQ) + length(datUkf.RR);

    datUkf.boDet = false;

    %
    % Calculate the sigma ponit weights for calculating the sigma point weighted
    % averages.  From van der Merwe & Wan "The Unscented Kalman Filter".
    %

    % From van der Merwe
%   kappa = 0.0;     % 0 or 3 - N ???
%   alpha = 1.0e-3;  % Seems to be a common value.  1 = no scaling.

    % From Vaujin
%   kappa = 3 - NN;
%   alpha = 0.8;

    %
    % Combination of van der Merwe and Vaujin
    %
    kappa = 3 - datUkf.NN;
    alpha = 1.0e-3;  % Seems to be a common value.  1 = no scaling.
    beta = 2.0;      % Optimal for gaussian statistics.

    lambda = alpha^2 * (datUkf.NN + kappa) - datUkf.NN;

    datUkf.sqrtNlambda = sqrt(datUkf.NN + lambda);

    datUkf.Wm0 = lambda / (datUkf.NN + lambda);
    datUkf.Wc0 = datUkf.Wm0 + (1.0 - alpha^2 + beta);
    datUkf.Wi = 0.5 / (datUkf.NN + lambda);

  else  

    %
    % Propagate state estimate.  First augment the state and covariance matrix 
    % to include the process and measurement noise.  Then create 2N + 1 sigma
    % points per Rudolph van der Merwe.
    % 
    Xa = [datUkf.Xkf; zeros(length(datUkf.QQ),1); zeros(length(datUkf.RR),1)];
    
    Pa = zeros(datUkf.NN,datUkf.NN);
    
    Pa(1:4, 1:4) = datUkf.PP;
    Pa(5,5) = datUkf.QQ(1,1);
    Pa(6,6) = datUkf.QQ(2,2);
    Pa(7,7) = datUkf.RR(1,1);
    
    %
    % Dan Simon's formulation:
    % Take the upper Cholesky square root of the augmented covariance matrix
    % such that Sa' * Sa = Pa.  Then extract the transposed rows of Sa.
    %
    Sa = chol(Pa);
    
    clear Xsig;
    Xsig(:,1) = Xa;
    for (idxSig = 1:datUkf.NN)
      Xsig(:,idxSig+1) = Xa + datUkf.sqrtNlambda * Sa(idxSig,:)';
      Xsig(:,datUkf.NN+idxSig+1) = Xa - datUkf.sqrtNlambda * Sa(idxSig,:)';
    end;
    
    %
    % Propagate each of the sigma points through the system dynamics and take
    % the mean.  Process noise, which is in the last elements of the augmented
    % state, is added to the associated states before passing through the 
    % system model.
    %
    clear XsigProp;
    for (idxSig = 1:2*datUkf.NN+1)
    
      XsigTemp(1:2,1) = Xsig(1:2,idxSig);
    
      XsigTemp(3,1) = Xsig(3,idxSig) + Xsig(5,idxSig);
    
      XsigTemp(4,1) = Xsig(4,idxSig) + Xsig(6,idxSig);
    
      XsigProp(:,idxSig) = propRktUKF(time, XsigTemp, dt);
    
    end;
    
    datUkf.Xkf = datUkf.Wm0 * XsigProp(:,1) + ...
                 datUkf.Wi * sum(XsigProp(:,2:end), 2);
    
    %
    % mDotOvrM should never go positive.  Once it crosses zero, declare burnout
    % and hold it at zero.
    %
    if ((datUkf.Xkf(4) > 0.0) || datUkf.boDet)
      datUkf.Xkf(4) = 0.0;
%      datUkf.PP(4,4) = SMALL;
      datUkf.boDet = true;
    end;
    
    %
    % Calculate the covariance of the sigma points relative to the new mean of
    % the propagated sigma points.
    %
    clear deltaXi;
    deltaX0 = XsigProp(:,1) - datUkf.Xkf;
    for (idxSig = 1:2*datUkf.NN)
      deltaXi(:,idxSig) = XsigProp(:,idxSig+1) - datUkf.Xkf;      
    end;
    
    datUkf.PP = datUkf.Wc0 * (deltaX0 * deltaX0') + ...
                datUkf.Wi * (deltaXi * deltaXi');

    %
    % Start the measurement (observarion) update.
    %
      
    %
    % Redraw the sigma points.  According to Wu-2005 this results in loss
    % of statistical integrity.  Create the aumented state and covariance.
    %
    Xa = [datUkf.Xkf; zeros(length(datUkf.QQ),1); zeros(length(datUkf.RR),1)];
    
    Pa = zeros(datUkf.NN,datUkf.NN);
    
    Pa(1:4, 1:4) = datUkf.PP;
    Pa(5,5) = datUkf.QQ(1,1);
    Pa(6,6) = datUkf.QQ(2,2);
    Pa(7,7) = datUkf.RR(1,1);
    
    %
    % Take the upper Cholesky square root of the augmented covariance matrix
    % such that Sa' * Sa = Pa
    %
    Sa = chol(Pa);
    
    clear Xsig;
    Xsig(:,1) = Xa;
    for (idxSig = 1:datUkf.NN)
      Xsig(:,idxSig+1) = Xa + datUkf.sqrtNlambda * Sa(idxSig,:)';
      Xsig(:,datUkf.NN+idxSig+1) = Xa - datUkf.sqrtNlambda * Sa(idxSig,:)';
    end;
    
    %
    % Extract the predicted measurements from the sigma points and add 
    % measurement noise.
    %
    Ysig = Xsig(1,:) + Xsig(7,:);
    
    %
    % The predicted measurement (observation) is the mean of the y sigma
    % points.
    %
    YY = datUkf.Wm0 * Ysig(:,1) + datUkf.Wi * sum(Ysig(:,2:end), 2);
    
    %
    % Calculate the predicted covariance of YY including the additive
    % measurement covariance.
    %
    clear deltaYi;
    deltaY0 = Ysig(:,1) - YY;
    for (idxSig = 1:2*datUkf.NN)
      deltaYi(:,idxSig) = Ysig(:,idxSig+1) - YY;
    end;
    
    Py = datUkf.Wc0 * (deltaY0 * deltaY0') + datUkf.Wi * (deltaYi * deltaYi');
    
    %
    % Estimate the X  Y cross covariance
    %
    clear deltaXi;
    deltaX0(:, 1) = Xsig(1:datUkf.nn,1) - datUkf.Xkf;
    for (idxSig = 1:2*datUkf.NN)
      deltaXi(:, idxSig) = Xsig(1:datUkf.nn,idxSig+1) - datUkf.Xkf; 
    end;
      
    Pxy = datUkf.Wc0 * (deltaX0 * deltaY0') + datUkf.Wi * (deltaXi * deltaYi');
    
    %
    % Calculate the gain
    %
    KK = Pxy * inv(Py);
    
    %
    % Update the state and covariance estimates
    %
    datUkf.Xkf = datUkf.Xkf + KK * (datUkf.ZZ - YY);
    %
    % mDotOvrM should never go positive.  Once it crosses zero, declare burnout
    % and hold it at zero.
    %
    if ((datUkf.Xkf(4) > 0.0) || datUkf.boDet)
      datUkf.Xkf(4) = 0.0;
%      datUkf.PP(4,4) = SMALL;
      datUkf.boDet = true;
    end;
    
    datUkf.PP = datUkf.PP - KK * Py * KK';

  end;  % if (time < dt) else

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% propRktUKF()
%
% Overview:
%
%  Second order Runga Kutta integrator.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Xnew = propRktUKF(time, XX, dt)

  %
  % Get derivative at prior time
  %
  derivK = derivRktUKF(time, XX);

  %
  % Get derivative at next (current) time step based on 1st order estimate
  % of current state.
  %
  stateIncrement = derivK * dt;

  Xtemp = XX + stateIncrement;

  %
  % Get the ECI derivative at the intermediate state
  %
  derivKp1 = derivRktUKF(time, Xtemp);

  %
  % The final state increment is calculated from the average of the prior
  % and next (current) temporary state derivatives.
  %
  stateIncrement = 0.5 * (derivK + derivKp1) * dt;

  Xnew = XX + stateIncrement;

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% derivRktUKF()
%
% Overview:
%
%  Constant mass flow rate, constant thrust, single stage, 1DOF rocket model.
%
%    X(1) = position
%    X(2) = velocity
%    X(3) = acceleration
%    X(4) = mDotOvrM
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxdt = derivRktUKF(time, XX)
  dxdt(1,1) = XX(2);
  dxdt(2,1) = XX(3);
  dxdt(3,1) = -XX(3) * XX(4);
  dxdt(4,1) = -XX(4)^2;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
