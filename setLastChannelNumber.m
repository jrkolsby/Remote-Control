% UNIS:adb2184, bxh2102, jrk2181, jll2219, ljt2130
% A helper method for the keypad that sets the last channel numbers that
% were pressed.
%
function setLastChannelNumber(v)
global tv;
tv.lastChannelNumber = v;
end