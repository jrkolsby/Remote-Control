% UNIS:adb2184, bxh2102, jrk2181, jll2219, ljt2130
% This method sets the last channel for the tv. Useful helper to
% the undo method.
function setLastChannel(c)
global tv;
tv.lastChannel = c;
end