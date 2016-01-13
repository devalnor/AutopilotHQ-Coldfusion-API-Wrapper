component {

	public any function init(
			required string apikey,
			required string serviceUrl,
			required any utils
		) {

		
		variables.host = arguments.serviceUrl;
		variables.apikey = arguments.apikey;
		variables.utils = arguments.utils;
		variables.httpRequester = server.keyExists( 'lucee' ) ? new http.lucee( arguments.utils ) : new http.coldfusion( arguments.utils );

		return this;
	}

	public any function call(
		string httpMethod = 'GET',
		string path = '/',
		any body,
		struct queryParams = {},
		struct headers = {}
	) {

		var api_request_headers = { 'autopilotapikey' : apikey, 'Content-Type': "application/json"};
   		api_request_headers.append( headers );

		var httpArgs = {};
		httpArgs[ 'httpMethod' ] = httpMethod;
		httpArgs[ 'path' ] = host & path;
		httpArgs[ 'headers' ] = api_request_headers;
		httpArgs[ 'queryParams' ] = queryParams;
		if ( !isNull( arguments.body ) ) httpArgs[ 'body' ] = body;
		//writeDump( httpArgs );

		var requestStart = getTickCount();
		var rawResponse = httpRequester.makeHttpRequest( argumentCollection = httpArgs );
	 	
	 	//writeDump( rawResponse );

		var apiResponse = {};
		apiResponse[ 'responseTime' ] = getTickCount() - requestStart;
		apiResponse[ 'responseHeaders' ] = rawResponse.responseheader;
		apiResponse[ 'statusCode' ] = listFirst( rawResponse.statuscode, ' ' );
		apiResponse[ 'statusText' ] = listRest( rawResponse.statuscode, ' ' );
		apiResponse[ 'rawData' ] = rawResponse.filecontent;
		apiResponse[ 'httpArgs' ] = httpArgs;
		

		if (rawResponse.header is '') {
			apiResponse[ 'error' ] = {};
			apiResponse[ 'error' ].error = rawResponse.filecontent;
	 		apiResponse[ 'error' ].message = rawResponse.errordetail;
		}
	
		return apiResponse;
	}

}