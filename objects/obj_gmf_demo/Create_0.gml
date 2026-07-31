/// @description 

var _fname = "/folder/subdir/file.ext"
show_debug_message(filename_dir(_fname))
show_debug_message(filename_path(_fname))
show_debug_message(filename_name(_fname))

gmf = new GMF("data.gmf")

// Generate object
gmf.Open()
gmf.AddDirectory("/gmf")
gmf.Save()

// Variables
files_selected = []

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
ViewFile = function(_filename) {
	dbg_set_view(view_file)
	dbg_section_delete(view_file_preview)
	view_file_preview = dbg_section("Preview", true)
	
	// File Preview
	dbg_text(_filename)
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
	for (var _i = 0; _i < 50; _i++) {
		files_selected[_i] = false
		
		dbg_checkbox(ref_create(self, "files_selected", _i), $"folder/subfolder/{_i}.txt")
		dbg_same_line()
		
		dbg_button("View", method({ ViewFile, file: _i}, function() {
			ViewFile(file)
		}), 40, 20)
		dbg_same_line()
		dbg_button("Remove", method({ ViewFile, file: _i}, function() {
			ViewFile(file)
		}), 60, 20)
		//dbg_same_line()
		//dbg_text()
	}
	
}

RefreshFiles()