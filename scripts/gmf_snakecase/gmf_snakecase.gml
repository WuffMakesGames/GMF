/// Creates a GMF object with a specific filepath
/// @arg {String} filename
/// @return {Struct.GMF}
function gmf_create(_filename) {
	return new GMF(_filename)
}

/// @arg {Struct.GMF} gmf
function gmf_open(_gmf) {
	return _gmf.Open()
}
