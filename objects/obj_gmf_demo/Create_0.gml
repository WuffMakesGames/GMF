/// @description 

gmf = new GMF()

// GMF View
view_gmf = dbg_view("Get Me the Files!", true, undefined, undefined, undefined, 600)
dbg_text("Get Me the Files!")
dbg_text("GameMaker file format for bundling game assets at runtime.")

// Controls
dbg_button("Load", function() {
	var _filename = get_open_filename("GMF (*.gmf)|*.gmf", "")
	if (_filename != "") gmf.Open(_filename)
	RefreshFiles()
}, 100, 20)

dbg_same_line()
dbg_button("Save", function() {
	var _filename = get_save_filename("GMF (*.gmf)|*.gmf", "")
	if (_filename != "") gmf.Save(_filename)
	RefreshFiles()
}, 100, 20)

dbg_same_line()
dbg_button("Add File", function() {
	var _filename = get_open_filename("Any Files (*.*)|*.*", "")
	if (_filename != "") gmf.AddFile(_filename)
	RefreshFiles()
}, 100, 20)

section_gmf_files = dbg_section("Files", true)

// File View
view_file = dbg_view("File Viewer", true)
section_viewer_main = dbg_section("View", true)

// Methods 
//===================================================================
ViewFile = function(_filename) {
	dbg_section_delete(section_viewer_main)
	dbg_set_view(view_file)
	section_viewer_main = dbg_section("View", true)
	dbg_text(_filename)
}

RefreshFiles = function() {
	dbg_section_delete(section_gmf_files)
	dbg_set_view(view_gmf)
	section_gmf_files = dbg_section("Files", true)
	
	// Generate GMF section
	for (var _i = 0; _i < 50; _i++) {
		dbg_button("View", method({ ViewFile, file: _i}, function() {
			ViewFile(file)
		}), 40, 20)
		dbg_same_line()
		dbg_text($"folder/subfolder/{_i}.txt")
	}
	
}

RefreshFiles()