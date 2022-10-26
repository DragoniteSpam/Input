
if (self.mouse_lock) {
    #region regular movement
    //look_dir -= (input_cursor_x() - window_get_width() / 2) / 10;
    //look_pitch -= (input_cursor_y() - window_get_height() / 2) / 10;
    self.look_dir -= input_mouse_dx() / 10;
    self.look_pitch -= input_mouse_dy() / 10;
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

if (keyboard_check_pressed(vk_tab)) {
    self.mouse_lock = !self.mouse_lock;
}