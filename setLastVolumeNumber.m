% UNIS:adb2184, bxh2102, jrk2181, jll2219, ljt2130
% A helper method for the keypad that sets the last numbers that
% were pressed.
%
function setLastVolumeNumber(v)
global tv;
tv.lastVolumeNumber = v;
end