
if (self.mouse_lock && self.last_cursor_x != undefined && self.last_cursor_y != undefined) {
    #region regular movement
    self.look_dir -= (input_cursor_x() - self.last_cursor_x) / 5;
    self.look_pitch -= (input_cursor_y() - self.last_cursor_y) / 5;
    self.look_pitch = clamp(self.look_pitch, -85, 85);
    
    if (input_check_pressed("pause")) {
        game_end();
    }
    
    var move_speed = 2;
    var dx = 0;
    var dy = 0;
    
    if (input_check("left")) {
        dx += dsin(self.look_dir) * move_speed;
        dy += dcos(self.look_dir) * move_speed;
    }
    
    if (input_check("right")) {
        dx -= dsin(self.look_dir) * move_speed;
        dy -= dcos(self.look_dir) * move_speed;
    }
    
    if (input_check("up")) {
        dx -= dcos(self.look_dir) * move_speed;
        dy += dsin(self.look_dir) * move_speed;
    }
    
    if (input_check("down")) {
        dx += dcos(self.look_dir) * move_speed;
        dy -= dsin(self.look_dir) * move_speed;
    }
    
    x += dx;
    y += dy;
    #endregion
}

if (input_check_pressed("action")) {
    self.mouse_lock = !self.mouse_lock;
    input_mouse_capture_set(self.mouse_lock);
}