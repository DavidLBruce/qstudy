%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rocket.m
%
% Overview:
%  1DOF boosting rocket model.
%
% Usage:
%  [datRkt] = rocket(time, dt);
%  Output will be written to rocket.txt in a format suitable for importing into
%  the workspace with
%   [dat] = loadDataFile('rocket.txt');
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
function [datRkt] = rocket(datRkt, time, dt)

  %
  % Unless specified otherwise, all units are mks & radians
  %

  %
  % Model parameters
  %
  datRkt.massProp = 200.0;  % Initial propellant mass
  datRkt.massDry = 100.0;   % Empty mass of rocket
  datRkt.mDot = -10.0;      % Motor mass flow rate
  datRkt.isp = 200.0;       % Propellant specific impulse

  %
  % Constants
  %
  gee = 9.81;

  if (time < dt)
    %
    % Initialize variables
    %
    datRkt.mass = datRkt.massDry + datRkt.massProp;
    datRkt.force = -datRkt.mDot * datRkt.isp * gee;
    datRkt.pos = 0.0;
    datRkt.vel = 0.0;
    datRkt.acc = datRkt.force / datRkt.mass;
    datRkt.mDotOvrM = datRkt.mDot / datRkt.mass;

    state(1,1) = datRkt.pos;  
    state(2,1) = datRkt.vel;  
    state(3,1) = datRkt.mass; 
  else
    state(1,1) = datRkt.pos;  
    state(2,1) = datRkt.vel;  
    state(3,1) = datRkt.mass; 
  
    state = integrate(datRkt, time, state, dt);

    datRkt.pos = state(1);
    datRkt.vel = state(2);
    if (datRkt.mass <= datRkt.massDry)
      datRkt.mass = datRkt.massDry;
      datRkt.mDot = 0.0;
    else
      datRkt.mass = state(3);
    end;

    datRkt.force = -datRkt.mDot * datRkt.isp * gee;

    datRkt.acc = datRkt.force / datRkt.mass;

    datRkt.mDotOvrM = datRkt.mDot / datRkt.mass;

  end;  % if (time < dt) else

return;

%
% Function to calculate state derivatives.
%
function [dxdt] = deriv(datRkt, time, state)

  gee = 9.81;

  mass = state(3);
  if (mass <= datRkt.massDry)
    mass = datRkt.massDry;
    mDot = 0.0;
  else
    mDot = datRkt.mDot;
  end;

  acc = -mDot * datRkt.isp * gee / mass;

  dxdt(1,1) = state(2); % Position
  dxdt(2,1) = acc;      % Velocity
  dxdt(3,1) = mDot;     % Mass

return;

%
% Fourth order Runge Kutta integrator.
%
function [state] = integrate(datRkt, time, state, dt)

  %
  % Step 1
  %
  dxdt = deriv(datRkt, time, state);

  k1 = dxdt * dt;

  tempState = state + k1 / 2.0;

  %
  % Advance clock by a half step for step 2 & 3.
  %
  time = time + dt / 2.0;

  %
  % Step 2
  %
  dxdt = deriv(datRkt, time, tempState);

  k2 = dxdt * dt;

  tempState = state + k2 / 2.0;

  %
  % Step 3
  %
  dxdt = deriv(datRkt, time, tempState);

  k3 = dxdt * dt;

  tempState = state + k3;

  %
  % Step 4
  %
  time = time + dt / 2.0;

  dxdt = deriv(datRkt, time, tempState);

  k4 = dxdt * dt;

  %
  % Now sum weighted delta states
  %
  state = state + k1/6.0 + k2/3.0 + k3/3.0 + k4/6.0;

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
