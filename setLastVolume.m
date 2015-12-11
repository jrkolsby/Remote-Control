% UNIS:adb2184, bxh2102, jrk2181, jll2219, ljt2130
% This method sets the last volume for the tv. Useful helper to
% the undo method.
function setLastVolume(v)
global tv;
tv.lastVolume = v;
end