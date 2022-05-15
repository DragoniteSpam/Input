/// @param [coordSpace]
/// @param [playerIndex=0]

enum INPUT_COORD_SPACE
{
    ROOM,
    GUI,
    DISPLAY,
    __SIZE
}

function input_cursor_coord_space_set(_coord_space, _player_index)
{
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_coord_space_set(_coord_space, _p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__cursor.__coord_space = _coord_space;
}