// By jcberquist Imported from https://github.com/jcberquist/aws-cfml

component {

  public any function init( 
    required any utils
  ) {
    variables.utils = utils;
    return this;
  }

  public any function makeHttpRequest( 
    required string httpMethod, 
    required string path, 
    required struct queryParams, 
    required struct headers, 
    any body
  ) {
    var result = '';
    var fullPath = utils.encodeUrl( path, false ) & ( !queryParams.isEmpty() ? ( '?' & utils.parseQueryParams( queryParams, false ) ) : '' );
    var request_headers = utils.parseHeaders( headers );

    cfhttp( url = 'https://' & fullPath, method = httpMethod, result = 'result' ) {

      for ( var header in request_headers ) {
          // if ( header.name == 'host' ) continue;
          httpparam type = "header" name = lcase( header.name ) value = header.value;
      }

      if ( arrayFindNoCase( [ 'POST','PUT' ], httpMethod ) && !isNull( arguments.body ) && isValid("string", body) ) {
        cfhttpparam( type = "body", value = body );
      }

    }
    return result;
  }

}