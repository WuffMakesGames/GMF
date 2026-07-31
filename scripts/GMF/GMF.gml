/// Get Me the Files!
function GMF() constructor {
	__buffer = -1
	__blob = 0 // Position of the blob in the buffer
	
	//===============================================================
	#region Methods
	
	/// Load a GMF object into memory. Returns -1 if the file cannot be loaded.
	/// @arg {String} filename The object file to load
	static Open = function(_filename) {
		if (!file_exists(_filename)) return -1;
		
	}
	
	/// Close the GMF object
	static Close = function() {
		
	}
	
	#endregion
	//===============================================================
	#region Setup
	
	/// Adds a file to the object
	/// @arg {String} filename
	static AddFile = function(_filename) {
		
	}
	
	/// Adds a directory to the object
	/// @arg {String} directory
	/// @arg {Bool} include_subfolders
	static AddDirectory = function(_directory, _include_subfolders=true) {
		
	}
	
	/// Saves the object to a file on disk
	/// @arg {String} filename The filename to save the object as
	static Save = function(_filename) {
		
	}
	
	#endregion
	//===============================================================
	#region File System
	
	/// Returns a struct representation of the file structure
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
	
	/// Returns a file contents as a buffer
	/// @arg {GMFile,String} file_or_path The file to load
	static Load = function(_file_or_path) {
		
	}
	
	#endregion
	//===============================================================
}