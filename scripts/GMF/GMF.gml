/// Get Me the Files!
/// @arg {String} filename The object file to load
function GMF(_filename) constructor {
	filename = _filename
	
	// Internal variables
	__directory_tree = {}
	__blob_buffer = -1
	
	//===============================================================
	#region Methods
	
	/// Load a GMF object into memory. Returns -1 if the file cannot be loaded. Returns 1 otherwise.
	/// @return {Real}
	static Open = function() {
		__directory_tree = {}
		__blob_buffer = buffer_create(100, buffer_grow, 1)
		
		// Try to load file
		if (!file_exists(filename)) return -1;
		var _buffer = buffer_load(filename)
		
		if (!buffer_exists(_buffer)) return -1;
		__ParseObject(_buffer)
		buffer_delete(_buffer)
		
		// Successfully loaded object
		return 1
	}
	
	/// Close the GMF object.
	static Close = function() {
		if (!buffer_exists(__blob_buffer)) show_error("[GMF] Tried to close unopened GMF object.", true)
		buffer_delete(__blob_buffer)
	}
	
	/// Returns true if the GMF object is currently open.
	/// @return {Bool}
	static IsOpen = function() {
		return buffer_exists(__blob_buffer)
	}
	
	/// Destroys any temporary files generated created by GMF during runtime.
	static Cleanup = function() {
		if (directory_exists("GMFTEMP")) directory_destroy("GMFTEMP")
	}
	
	/// Saves the object to a file on disk.
	static Save = function() {
		
	}
	
	#endregion
	//===============================================================
	#region Building
	
	/// Adds a buffer to the object.
	/// @arg {Id.Buffer} buffer
	/// @arg {Real} offset
	/// @arg {Real} size
	/// @arg {Bool} compress
	/// @return {Struct.GMFile}
	static AddBuffer = function(_filename, _buffer, _offset=0, _size=buffer_get_size(_buffer), _compress=true) {
		if (!buffer_exists(__blob_buffer)) show_error("[GMF] Cannot add files to an unopened GMF object.", true)
		var _dir = filename_dir(_filename)
		var _name = filename_name(_filename)
		var _path = __ParsePath(_dir, true)
		
		// Create file
		var _blob_offset = buffer_get_used_size(__blob_buffer)
		var _file = new GMFile(filename_path(_filename), _name, _blob_offset, _size, _compress)
		struct_set(_path, _name, _file)
		
		// Add compressed buffer to blob
		if (_compress) {
			var _buffer_compressed = buffer_compress(_buffer, _offset, _size)
			_file.size = buffer_get_size(_buffer_compressed)
			buffer_copy(_buffer_compressed, 0, _file.size, __blob_buffer, _blob_offset)
			
			// Delete compressed buffer
			buffer_delete(_buffer_compressed)
			show_debug_message("Compressed file: {0}", _filename)
		
		// Add uncompressed buffer to blob
		} else {
			buffer_copy(_buffer, _offset, _size, __blob_buffer, _blob_offset)
			
		}
		
		// Return
		return _file
	}
	
	/// Adds a file to the object.
	/// @arg {String} filename Path to the file on disk
	/// @arg {Bool} compress Whether to compress the file data
	/// @arg {String} relative_filename The path to the file in the object
	/// @return {Struct.GMFile}
	static AddFile = function(_filename, _compress=true, _relative_filename=_filename) {
		var _buffer = buffer_load(_filename)
		var _file = AddBuffer(_relative_filename, _buffer, 0, buffer_get_size(_buffer), _compress)
		buffer_delete(_buffer)
		return _file
	}
	
	/// Adds a directory to the object.
	/// @arg {String} directory
	/// @arg {Bool} compress
	/// @arg {Bool} include_subfolders
	static AddDirectory = function(_directory, _compress=true, _include_subfolders=true) {
		if (!string_ends_with(_directory, "/")) _directory = _directory + "/"
		var _directories = [_directory]
		var _files = []
		
		// Search directories
		while (array_length(_directories) > 0) {
			var _root = array_pop(_directories)
			var _file = file_find_first(_root + "*", fa_directory)
			
			// Search directory files
			while (_file != "") {
				var _filename = _root + _file
				
				// Add folder
				if (directory_exists(_filename) && _include_subfolders) {
					array_push(_directories, _filename + "/")
					
				// Add file
				} else if (file_exists(_filename)) {
					array_push(_files, _filename)
					
				}
				_file = file_find_next()
			}
			
			file_find_close()
		}
		
		// Add all files to object
		for (var _i = 0; _i < array_length(_files); _i++) {
			AddFile(_files[_i], _compress, string_replace(_files[_i], _directory, ""))
		}
	}
	
	/// Removes a file from the object.
	/// @arg {String} filename The file to remove
	static RemoveFile = function(_filename) {
		
	}
	
	/// Removes an entire directory from the object.
	/// @arg {String} directory The directory to remove
	/// @arg {Bool} only_remove_empty Only remove the directory if it is empty
	static RemoveDirectory = function(_directory, _only_remove_empty=false) {
		
	}
	
	static MakeDirectory = function(_path) {
		
	}
	
	#endregion
	//===============================================================
	#region File System
	
	/// Returns a file object
	/// @return {Struct.GMFile}
	static GetFile = function(_path) {
		// TODO: Implement
		return _path
	}
	
	/// Returns a struct representation of the file structure.
	/// @arg {String} root The first folder in the directory to fetch
	/// @arg {Bool} include_subfolders Whether or not to include the contents of subfolders
	static GetDirectory = function(_root="/", _include_subfolders=true) {
		return __ParsePath(_root, false)
	}
	
	/// Writes a file from the object to disk. 
	/// @arg {GMFile,String} file_or_path The file to preload
	/// @arg {String} filename The filename to write to
	static Prefetch = function(_file_or_path, _filename) {
		var _buffer = Fetch(_file_or_path)
		buffer_save(_buffer, _filename)
		buffer_delete(_buffer)
	}
	
	/// Returns a files contents as a buffer.
	/// @arg {GMFile,String} file_or_path The file to load
	static Fetch = function(_file_or_path) {
		if (is_string(_file_or_path)) _file_or_path = GetFile(_file_or_path)
		
		// Fetch buffer
		var _buffer = buffer_create(_file_or_path.size, buffer_grow, 1)
		buffer_copy(__blob_buffer, _file_or_path.offset, _file_or_path.size, _buffer, 0)
		
		// Decompress buffer
		if (_file_or_path.compressed) {
			var _temp_buffer = buffer_decompress(_buffer)
			show_debug_message("Decompressed file: {0}", _file_or_path.path + _file_or_path.name)
			buffer_delete(_buffer)
			_buffer = _temp_buffer
		}
		
		// Return
		return _buffer
	}
	
	/// Returns a files contents as a string.
	/// @arg {GMFile,String} file_or_path The file to load
	static FetchText = function(_file_or_path) {
		var _buffer = Fetch(_file_or_path)
		var _text = buffer_read(_buffer, buffer_text)
		buffer_delete(_buffer)
		return _text
	}
	
	/// Checks if a file exists at the given path
	/// @arg {String} path
	static FileExists = function(_path) {
		
	}
	
	#endregion
	//===============================================================
	#region Internal
	
	/// Parses a path and returns the struct or file at its location
	/// @arg {String} path Path to parse
	/// @arg {Bool} generate_directory Whether to generate the folders leading up to the path
	static __ParsePath = function(_path, _generate_directory=false) {
		var _steps = string_split(_path, "/", true)
		var _root = __directory_tree
		
		for (var _i = 0; _i < array_length(_steps); _i++) {
			var _name = _steps[_i]
			if (!struct_exists(_root, _name)) struct_set(_root, _name, {})
			_root = struct_get(_root, _name)
		}
		
		//show_debug_message("Parsed path: {0} -> {1}", _path, _steps)
		return _root
	}
	
	/// Parse a GMF object from a buffer
	/// @arg {Id.Buffer} buffer
	static __ParseObject = function(_buffer) {
		
	}
	
	/// Store the GMF object to a buffer
	/// @return {Id.Buffer}
	static __StoreObject = function() {
		
	}
	
	#endregion
	//===============================================================
}