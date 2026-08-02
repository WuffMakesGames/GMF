# GMF
Get Me the Files! GameMaker file format for bundling game assets at runtime.

# Documentation

## Constructors
<!----------------------- METHOD ----------------------->
### `GMF`
Creates a new GMF object 
```js
new GMF(filename)
```
| Name | Type | Description |
|------|------|-------------|
|filename | String | The object file to load |

Returns: `Struct.GMF`
```js
// Example
gmf = new GMF("data.gmf")
gmf.Open()
```
This example opens a GMF object, loads a sprite and then closes the object.

## Methods
<!----------------------- METHOD ----------------------->
### `GMF.Open`
Load a GMF object into memory. Returns -1 if the file cannot be loaded. Returns 1 otherwise.
```js
success = gmf.Open();
```

Returns: `N/A` 
```js
// Example
gmf.Open()
gmf.Prefetch("images/player.png", "temp/player.png")
sprite = sprite_add("temp/player.png", 1, false, false, 0, 0)
gmf.Close()
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.Close`
Close the GMF object. Throws an error if the object wasn't open before closing.
```js
gmf.Close()
```

Returns: `N/A`
```js
// Example
gmf.Close()
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.IsOpen`
Returns true if the GMF object is currently open.
```js
gmf.IsOpen()
```

Returns: `Boolean`
```js
// Example
if (gmf.IsOpen()) {
	gmf.Close()
	show_debug_message("Closed GMF Object.")
}
```
This example checks if a GMF object is open and closes it when it is.

<!----------------------- METHOD ----------------------->
---
### `GMF.Save`
Saves the object to a file.
```js
gmf.Save()
```

Returns: `N/A`
```js
// Example
```
TODO: Explain example

## Building
<!----------------------- METHOD ----------------------->
### `GMF.AddBuffer`
Adds a buffer to the object.
```js
gmf.AddBuffer(filename, buffer, offset, size, compress)
```
| Name | Type | Description |
|------|------|-------------|
|filename 	| String | The path to the file in the object |
|buffer 	| Id.Buffer |  |
|offset 	| Real |  |
|size 		| Real |  |
|compress 	| Bool | Whether to compress the file data |

Returns: `Struct.GMFile`
```js
// Example
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.AddFile`
Adds a file to the object.
```js
gmf.AddFile(filename, compress, relative_filename)
```
| Name | Type | Description |
|------|------|-------------|
|filename 			| String 	| Path to the file on disk |
|compress 			| Bool 		| Whether to compress the file data |
|relative_filename 	| String 	| The path to the file in the object |

Returns: `Struct.GMFile`
```js
// Example
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.AddDirectory`
Adds the items in a directory to the object.
```js
gmf.AddDirectory(directory, compress, include_subfolders)
```
| Name | Type | Description |
|------|------|-------------|
|directory 			| String 	|  |
|compress 			| Bool 		|  |
|include_subfolders | Bool 		|  |

Returns: `N/A`
```js
// Example
```
TODO: Explain example

## Filesystem
<!----------------------- METHOD ----------------------->
### `GMF.GetFile`
Returns a file object
```js
gmf.GetFile(path)
```
| Name | Type | Description |
|------|------|-------------|
| path | String |  |

Returns: `Struct.GMFile`
```js
// Example
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.GetDirectory`
Returns a struct representation of the file structure.
```js
gmf.GetDirectory(root)
```
| Name | Type | Description |
|------|------|-------------|
| root | String | The first folder in the directory to fetch |

Returns: `Struct`
```js
// Example
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.Prefetch`
Writes a file from the object to disk. 
/// @arg {GMFile,String} file_or_path The file to preload
/// @arg {}  
```js
gmf.Prefetch(file_or_path, filename)
```
| Name | Type | Description |
|------|------|-------------|
| file_or_path | Struct.GMFile OR String | The file to save to disk |
| filename | String | The file to save the data to |

Returns: `N/A`
```js
// Example
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.Fetch`
Returns a contents of a file as a buffer.
```js
gmf.Fetch(file_or_path)
```
| Name | Type | Description |
|------|------|-------------|
| file_or_path | Struct.GMFile OR String | The file to load |

Returns: `Id.Buffer`
```js
// Example
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.FetchText`
Returns the contents of a file as a string.
	/// @arg {} 
```js
gmf.FetchText(file_or_path)
```
| Name | Type | Description |
|------|------|-------------|
| file_or_path | Struct.GMFile OR String | The file to load |

Returns: `String`
```js
// Example
```
TODO: Explain example

<!----------------------- METHOD ----------------------->
---
### `GMF.FileExists`
Checks if a file exists at the given path
/// @arg {String} 
```js
gmf.FileExists(path)
```
| Name | Type | Description |
|------|------|-------------|
| path | String |  |

Returns: `Bool`
```js
// Example
```
TODO: Explain example
