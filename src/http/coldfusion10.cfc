// Adaption for old CF10 server

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
    var request_headers = parseHeaders( headers );

    httpService = new http();
    httpService.setMethod(httpMethod);
    httpService.setCharset("utf-8");
    httpService.setUrl('https://' & fullPath);
   
    for ( var header in request_headers ) {
      httpService.addParam(type="header", name=lcase( header.name ), value=header.value); 
    }

    if ( arrayFindNoCase( [ 'POST','PUT' ], httpMethod ) && !isNull( arguments.body ) && isValid("string", body) ) {
      httpService.addParam(type="body", value=body, encoded="yes");
    }

    result = httpService.send().getPrefix();
    return result;
  }


  private array function parseHeaders( required struct headers ) {
    var sortedKeyArray = StructKeyArray(headers);
    
    arraySort(sortedKeyArray,"textnocase"); // sortedKeyArray.sort( 'textnocase' );
    
    processedHeaders=[];

    for( var i=1; i <= ArrayLen(sortedKeyArray); i++) {
      //writedump(i);
      //abort;
      key=sortedKeyArray[i];
      processedHeaders[i] = { name: lcase(key), value: trim( headers[ key ] ) };
    }

    return processedHeaders;
  }

}