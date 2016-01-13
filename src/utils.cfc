component {

	public any function init() {
		return this;
	}

	public any function serializeJSON( required any var) {
		return SerializeJSON(var);
	}

	public array function parseHeaders( required struct headers ) {
		var sortedKeyArray = headers.keyArray();
		sortedKeyArray.sort( 'textnocase' );
		var processedHeaders = sortedKeyArray.map( function( key ) { return { name: key.lcase(), value: trim( headers[ key ] ) }; } );
		return processedHeaders;
	}

	public string function parseQueryParams( required struct queryParams, boolean encodeQueryParams = true, boolean includeEmptyValues = true ) {
		var sortedKeyArray = queryParams.keyArray();
		sortedKeyArray.sort( 'textnocase' );
		
		var queryString = arrayReduce( sortedKeyArray, function( queryString, queryParamKey ) {
			var encodedKey = encodeQueryParams ? encodeUrl( queryParamKey ) : queryParamKey;
			var encodedValue = encodeQueryParams && len( queryParams[ queryParamKey ] ) ? encodeUrl( queryParams[ queryParamKey ] ) : queryParams[ queryParamKey ];
			return queryString.listAppend( encodedKey & ( includeEmptyValues || len( encodedValue ) ? ( '=' & encodedValue ) : '' ), '&' );
		}, '' );
		
		return queryString;
	}

	public string function encodeUrl( required string str, boolean encodeSlash = true ) {
		var result = replacelist( urlEncodedFormat( arguments.str, 'utf-8' ), '%2D,%2E,%5F,%7E', '-,.,_,~' );
		if ( !encodeSlash ) result = replace( result, '%2F', '/', 'all' );
		return result;
	}


}