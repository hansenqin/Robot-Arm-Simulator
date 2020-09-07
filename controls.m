function [a] = controls(~, event)                               % buttons                         
    switch event.Key
        case 'leftarrow'
            a = 1;
        case 'rightarrow'
            a = 2;
    end
end