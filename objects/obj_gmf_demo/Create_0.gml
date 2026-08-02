/// @description 

//var _fname = "/folder/subdir/file.ext"
//show_debug_message(filename_dir(_fname))
//show_debug_message(filename_path(_fname))
//show_debug_message(filename_name(_fname))

gmf = new GMF("data.gmf")

// Generate object
gmf.Open()
gmf.AddDirectory("gmf/", true)
gmf.Save()

// Variables
files_selected = []

sprite_preview = -1
sprite_imgnum = 0

ref_to_sprite = ref_create(self, "sprite_preview")
ref_to_imgnum = ref_create(self, "sprite_imgnum")

// Views and sections
view_gmf = dbg_view("Get Me the Files!", true, 60, 60, undefined, 600)
view_gmf_files = dbg_section("GMF Object", true)

view_file = dbg_view("File Viewer", true, 680, 60)
view_file_preview = dbg_section("Preview", true)

// Preview ==========================================================
dbg_set_section(view_file_preview)
dbg_text("Select a file to view it")

// Methods 
//===================================================================
ViewFile = function(_file_or_filename) {
	dbg_set_view(view_file)
	dbg_section_delete(view_file_preview)
	
	// Reset
	if (sprite_exists(sprite_preview)) sprite_delete(sprite_preview)
	
	// Create section
	view_file_preview = dbg_section(_file_or_filename.name, true)
		
	// File Preview
	switch (filename_ext(_file_or_filename.name)) {
		case ".gif": {
			gmf.Prefetch(_file_or_filename, "temp/preview.gif")
			sprite_preview = sprite_add_gif("temp/preview.gif", 0, 0, undefined, undefined)
			dbg_sprite(ref_to_sprite, ref_to_imgnum)
			break
		}
		case ".png": {
			gmf.Prefetch(_file_or_filename, "temp/preview.png")
			sprite_preview = sprite_add("temp/preview.png", 1, false, false, 0, 0)
			dbg_sprite(ref_to_sprite, ref_to_imgnum)
			break
		}
		default: {
			dbg_text(gmf.FetchText(_file_or_filename))
			break
		}
	}
}

RefreshFiles = function() {
	dbg_set_view(view_gmf)
	dbg_section_delete(view_gmf_files)
	view_gmf_files = dbg_section("Files", true)
	
	// Description
	dbg_text("Get Me the Files!")
	dbg_text("GameMaker file format for bundling game assets at runtime.")
	
	// File controls
	dbg_button("Add File", function() {
		var _filename = get_open_filename("Any Files (*.*)|*.*", "")
		if (_filename != "") gmf.AddFile(_filename)
		RefreshFiles()
	}, 100, 20)
	
	dbg_same_line()
	dbg_button("Select All", function() {
		
	}, 100, 20)
	
	dbg_same_line()
	dbg_button("Deselect All", function() {
		
	}, 100, 20)
	
	dbg_same_line()
	dbg_button("Remove Selected", function() {
		
	}, 140, 20)
	
	// Separator
	dbg_text_separator("File Tree", 0)
	
	// File tree
	var _directories = [gmf.GetDirectory("/")]
	while (array_length(_directories) > 0) {
		var _dir = array_pop(_directories)
		var _files = struct_get_names(_dir)
		
		for (var _i = 0; _i < array_length(_files); _i++) {
			var _item = struct_get(_dir, _files[_i])
			
			// Add file
			if (is_instanceof(_item, GMFile)) {
				dbg_checkbox(ref_create(self, "files_selected", _i), _item.path + _item.name)
				dbg_same_line()
				dbg_button("View", method({ ViewFile, file: _item}, function() {
					ViewFile(file)
				}), 40, 20)
				dbg_same_line()
				dbg_button("Remove", method({ gmf, file: _item}, function() {
					gmf.RemoveFile(file)
				}), 60, 20)
				
			// Add folder
			} else {
				array_push(_directories, _item)
			}
		}
	}
}

RefreshFiles()