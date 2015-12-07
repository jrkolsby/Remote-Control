function updateInfobox()
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ', Volume: ' , getCurrentVolume()));
end
