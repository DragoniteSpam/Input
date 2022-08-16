/// @param key
/// @param value

function __input_gamepad_keyword_config_set(_key, _value)
{
    global.__input_gamepad_keyword_config[$ string(_key)] = _value;
}