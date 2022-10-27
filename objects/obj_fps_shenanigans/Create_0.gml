// shush
var penguin_load = function(filename, vertex_format) {
    var mesh_cache = { };
    var buffer = -1;
    
    try {
        buffer = buffer_load(filename);
        var header = buffer_read(buffer, buffer_string);
        
        if (header != "derg") {
            throw {
                message: "Bad file header",
                longMessage: "please don't bother messing with this file",
                stacktrace: debug_get_callstack(),
                script: penguin_load,
            };
        }
        
        buffer_read(buffer, buffer_u32);                    // texture count - not used here
        
        var count = buffer_read(buffer, buffer_u32);
        
        repeat (count) {
            var penguin_name = buffer_read(buffer, buffer_string);
            buffer_read(buffer, buffer_string);             // internal name
            buffer_read(buffer, buffer_string);             // guid
            buffer_read(buffer, buffer_u64);                // flag
            buffer_read(buffer, buffer_u8);                 // type
            var xmin = buffer_read(buffer, buffer_s16);
            var ymin = buffer_read(buffer, buffer_s16);
            var zmin = buffer_read(buffer, buffer_s16);
            var xmax = buffer_read(buffer, buffer_s16);
            var ymax = buffer_read(buffer, buffer_s16);
            var zmax = buffer_read(buffer, buffer_s16);
            
            buffer_seek(buffer, buffer_seek_relative, (xmax - xmin) * (ymax - ymin) * (zmax - zmin) * buffer_sizeof(buffer_u64));
            buffer_read(buffer, buffer_u32);    // submesh count - it's 1
            
            {
                // skipping data not used here
                buffer_read(buffer, buffer_string);
                buffer_read(buffer, buffer_string);
                buffer_seek(buffer, buffer_seek_relative, buffer_sizeof(buffer_u32) * 4);
                repeat (9) buffer_read(buffer, buffer_string);
                
                buffer_read(buffer, buffer_u8);
                var size = buffer_read(buffer, buffer_u32);
                var vertex_data = buffer_create(size, buffer_fixed, 1);
                buffer_copy(buffer, buffer_tell(buffer), size, vertex_data, 0);
                buffer_seek(buffer, buffer_seek_relative, size);
                mesh_cache[$ penguin_name] = vertex_create_buffer_from_buffer(vertex_data, vertex_format);
                buffer_delete(vertex_data);
            }
            
            buffer_read(buffer, buffer_u32);                // shape count - not used here
            buffer_read(buffer, buffer_bool);               // terrain data - not used here
        }
    } catch (e) {
        show_message("Couldn't load mesh data: " + e.message + " (" + e.longMessage + ")");
        mesh_cache = { };
    } finally {
        if (buffer_exists(buffer))
            buffer_delete(buffer);
    }
    
    return mesh_cache;
};

self.look_dir = 135;
self.look_pitch = 0;
self.mouse_lock = false;

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_colour();
var format = vertex_format_end();

var meshes = penguin_load("examples/3dshenanigans.derg", format);
var mesh_keys = variable_struct_get_names(meshes);

var object_count = 400;
self.objects = array_create(object_count);

for (var i = 0; i < object_count; i++) {
    self.objects[i] = {
        x: random(room_width),
        y: random(room_height),
        mesh: meshes[$ mesh_keys[irandom(array_length(mesh_keys) - 1)]],
        scale: random_range(0.9, 1.1),
    };
}

self.last_cursor_x = undefined;
self.last_cursor_y = undefined;

input_cursor_speed_set(16);