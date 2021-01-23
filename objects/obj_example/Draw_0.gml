var _string  = "Left          = " + string(input_value(VERB.LEFT   )) + "    " + string(input_binding_get_name(input_binding_get(VERB.LEFT   ))) + "\n";
    _string += "Right         = " + string(input_value(VERB.RIGHT  )) + "    " + string(input_binding_get_name(input_binding_get(VERB.RIGHT  ))) + "\n";
    _string += "Up            = " + string(input_value(VERB.UP     )) + "    " + string(input_binding_get_name(input_binding_get(VERB.UP     ))) + "\n";
    _string += "Down          = " + string(input_value(VERB.DOWN   )) + "    " + string(input_binding_get_name(input_binding_get(VERB.DOWN   ))) + "\n";
    _string += "Confirm       = " + string(input_value(VERB.CONFIRM)) + "    " + string(input_binding_get_name(input_binding_get(VERB.CONFIRM))) + "\n";
    _string += "Cancel        = " + string(input_value(VERB.CANCEL )) + "    " + string(input_binding_get_name(input_binding_get(VERB.CANCEL ))) + "\n";
    _string += "Pause         = " + string(input_value(VERB.PAUSE  )) + "    " + string(input_binding_get_name(input_binding_get(VERB.PAUSE  ))) + "\n";
    _string += "Recent (all)  = " + string(input_check_press_most_recent()) + "\n";
    _string += "Recent (4dir) = " + string(input_check_press_most_recent([VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN])) + "\n";

draw_text(10, 10, _string);

var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    if (input_player_connected(_i))
    {
        var _x = input_cursor_x(_i);
        var _y = input_cursor_y(_i);
        
        draw_circle(_x, _y, 4, false);
        draw_circle(_x, _y, 6, true);
        draw_text(_x + 5, _y + 5, _i);
    }
    
    ++_i;
}