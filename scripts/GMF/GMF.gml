/// Get Me the Files!
/// @arg {String} filename The object file to load
function GMF(_filename) constructor {
	filename = _filename
	
	// Internal variables
	__buffer = -1
	__blob = 0 // Position of the blob in the buffer
	__directory_tree = {}
	
	//===============================================================
	#region Methods
	
	/// Load a GMF object into memory. Returns -1 if the file cannot be loaded. Returns 1 otherwise.
	/// @return {Real}
	static Open = function() {
		if (!file_exists(filename)) return -1;
		
		// Successfully opened object
		return 1
	}
	
	/// Close the GMF object.
	static Close = function() {
		if (!buffer_exists(__buffer)) show_error("[GMF] Tried to close unopened GMF object.", true)
		buffer_delete(__buffer)
	}
	
	/// Returns true if the GMF object is currently open.
	/// @return {Bool}
	static IsOpen = function() {
		return buffer_exists(__buffer)
	}
	
	#endregion
	//===============================================================
	#region Building
	
	/// Adds a file to the object.
	/// @arg {String} filename
	/// @arg {Bool} compress
	static AddFile = function(_filename, _compress=true) {
		var _buffer = buffer_load(_filename)
		AddBuffer(_filename, _buffer, buffer_get_size(_buffer), _compress)
		buffer_delete(_buffer)
	}
	
	/// Adds a buffer to the object.
	/// @arg {Id.Buffer} buffer
	/// @arg {Real} offset
	/// @arg {Real} size
	/// @arg {Bool} compress
	static AddBuffer = function(_filename, _buffer, _offset=0, _size=buffer_get_size(_buffer), _compress=true) {
		
	}
	
	/// Adds a directory to the object.
	/// @arg {String} directory
	/// @arg {Bool} include_subfolders
	static AddDirectory = function(_directory, _include_subfolders=true) {
		
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
	
	/// Saves the object to a file on disk.
	static Save = function() {
		
	}
	
	#endregion
	//===============================================================
	#region File System
	
	/// Returns a struct representation of the file structure.
	/// @arg {String} root The first folder in the directory to fetch
	/// @arg {Bool} include_subfolders Whether or not to include the contents of subfolders
	static GetDirectory = function(_root="/", _include_subfolders=true) {
		
	}
	
	/// Writes a file from the object to disk. Returns the resulting path to the file.
	/// @arg {GMFile,String} file_or_path The file to preload
	/// @arg {String} filename The filename to write to
	/// @return {String}
	static Preload = function(_file_or_path, _fname=undefined) {
		
	}
	
	/// Returns a file contents as a buffer.
	/// @arg {GMFile,String} file_or_path The file to load
	static Load = function(_file_or_path) {
		
	}
	
	#endregion
	//===============================================================
	#region Internal
	
	static __ParseObject = function() {
		
	}
	
	#endregion
	//===============================================================
}