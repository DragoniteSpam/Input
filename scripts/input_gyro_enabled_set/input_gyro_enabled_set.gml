function input_gyro_enabled_set(_state, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX

    global.__input_players[_player_index].__gyro_enabled = _state;
}