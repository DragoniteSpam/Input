draw_clear(c_black);

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_blendenable(false);

var camera = camera_get_active();

var xfrom = self.x;
var yfrom = self.y;
var zfrom = 24;
var xto = xfrom - dcos(self.look_dir) * dcos(self.look_pitch);
var yto = yfrom + dsin(self.look_dir) * dcos(self.look_pitch);
var zto = zfrom + dsin(self.look_pitch);

var view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
var proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 1000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

draw_sprite_tiled_ext(spr_white, 0, 0, 0, 1, 1, c_green, 1);

gpu_set_cullmode(cull_counterclockwise);

shader_set(shd_fps_shenanigans);
for (var i = 0, n = array_length(self.objects); i < n; i++) {
    var object_data = self.objects[i];
    matrix_set(matrix_world, matrix_build(object_data.x, object_data.y, 0, 0, 0, 0, object_data.scale, object_data.scale, object_data.scale));
    vertex_submit(object_data.mesh, pr_trianglelist, -1);
}
matrix_set(matrix_world, matrix_build_identity());
shader_reset();

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_blendenable(true);
gpu_set_cullmode(cull_noculling);