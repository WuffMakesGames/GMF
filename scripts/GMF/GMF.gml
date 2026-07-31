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
	static AddBuffer = function(_filename, _buffer, _offset=0, _size=buffer_get_size(_buffer), _compress=true) {
		if (!buffer_exists(__blob_buffer)) show_error("[GMF] Cannot add files to an unopened GMF object.", true)
		
	}
	
	/// Adds a file to the object.
	/// @arg {String} filename
	/// @arg {Bool} compress
	static AddFile = function(_filename, _compress=true) {
		var _buffer = buffer_load(_filename)
		AddBuffer(_filename, _buffer, buffer_get_size(_buffer), _compress)
		buffer_delete(_buffer)
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
	static Prefetch = function(_file_or_path, _fname=undefined) {
	}
	
	/// Returns a file contents as a buffer.
	/// @arg {GMFile,String} file_or_path The file to load
	static Fetch = function(_file_or_path) {
		
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