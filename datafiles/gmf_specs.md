# Get Me the Files!

GMF Files consist of two main portions, the header, and the blob.
The header is a list of chunks that contain file data, and the blob contains all of the file data stored without any additional information.

To locate a file in the blob, you must first parse the header chunks to find it's offset and size,
and then use that information to read a chunk of binary from the blob.

## Header
The header starts with four ascii bytes to indicate the format version.
Usually GMF and a number. (current version: GMF1)  
The rest of the header contains a list of chunks, each starting with a string denoting the chunk type.
All of the chunks that the header can contain are:

### FOLDER
Defines a directory for the following FILE chunks. Can include subdirectories.  
Available aince GMF1.
| Name | Type | Description |
|------|------|-------------|
| Name | String  | The name of the folder. |
| Items | String | The number of items in the folder. |

### FILE
A file entry. Can be used to locate a file in the blob.  
Available aince GMF1.
| Name | Type | Description |
|------|------|-------------|
| Size | String | The length of the entry in bytes. |
| Name | String | The name of the file. |
| Compressed | Bool   | Whether or not the file has been compressed. |
| Offset     | String | The offset in bytes of the file in the blob. |
| Bytes      | String | The size of the blob entry in bytes. |

### BLOB
Marks the end of the header and the beginning of the blob section. The blob contains all of the file data.  
Available aince GMF1.
| Name | Type | Description |
|------|------|-------------|
| Data | Bytes | Unmarked blob contents. |
