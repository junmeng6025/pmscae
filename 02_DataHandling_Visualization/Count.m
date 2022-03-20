function [nextInc_global, nextInc_persistent] = Count()
% declare global and persistent variables
global globalCounter
persistent persistentCounter
% check if persistent variable has been initialized
if isempty(persistentCounter)
    persistentCounter = 0;
else
    persistentCounter = persistentCounter + 1;
end
% call global counter function
incGlobalCounter;
% return results
nextInc_global = globalCounter;
nextInc_persistent = persistentCounter;
end

function incGlobalCounter()
% declare global variable
global globalCounter
% check if global variable has been initialized
if isempty(globalCounter)
    globalCounter = 0;
else
    globalCounter = globalCounter + 1;
end
end