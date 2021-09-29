/// @param binding
function input_mouse_check_released(_binding)
{
    if (__INPUT_ON_PS && INPUT_TOUCH_POINTER_ALLOWED && (_binding == mb_left))
    {
        return global.__input_pointer_released;
    }
    
    if (global.__input_mouse_blocked) 
    {
        return false;
    }
    
    if (__INPUT_TOUCH_SUPPORT)
    {
        //Extended buttons only report on first index
        var _extended_release = (device_mouse_check_button_released(0, mb_any) && !device_mouse_check_button_released(0, mb_left));
            
        switch (_binding)
        {
            case mb_left: return   global.__input_pointer_released; break;
            case mb_any:  return  (global.__input_pointer_released || _extended_release); break;
            case mb_none: return !(global.__input_pointer_released || _extended_release); break;
        }
    }

    return device_mouse_check_button_released(0, _binding);
}