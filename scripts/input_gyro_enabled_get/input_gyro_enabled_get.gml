function input_gyro_enabled_get(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX

    return global.__input_players[_player_index].__gyro_enabled;
}