component {

	public any function init(
			required string apikey,
			required string serviceUrl,
			required any utils
		) {
	
		// Api Settings
		variables.host = arguments.serviceUrl;
		variables.apikey = arguments.apikey;
		variables.utils = arguments.utils;

		// Define Server Environement
		if (structKeyExists(server, "lucee")) {
			variables.httpRequester = new http.lucee(arguments.utils);
			variables.env="lucee";
		} else {
			if(listfirst(server.coldfusion.productversion) is "10") {
				variables.env="cf10";
				variables.httpRequester = new http.coldfusion10(arguments.utils);
			} else {
				variables.env="cf";
				variables.httpRequester = new http.coldfusion(arguments.utils);	
			}
		}

		return this;
	}

	public any function call(
		string httpMethod = 'GET',
		string path = '/',
		any body,
		struct queryParams = {},
		struct headers = {}
	) {

		// Set Content Type
		var api_request_headers = { 'autopilotapikey' : apikey, 'Content-Type': "application/json"};
		
		// Append headers 
		if (env is "cf10") {
			StructAppend(api_request_headers, headers);
   		} else {
	   		api_request_headers.append( headers );
   		}

   		// Set httpArgs
		var httpArgs = {};
		httpArgs[ 'httpMethod' ] = httpMethod;
		httpArgs[ 'path' ] = host & path;
		httpArgs[ 'headers' ] = api_request_headers;
		httpArgs[ 'queryParams' ] = queryParams;
		if ( !isNull( arguments.body ) ) httpArgs[ 'body' ] = body;

		var requestStart = getTickCount();

		// Http Request
		var rawResponse = httpRequester.makeHttpRequest( argumentCollection = httpArgs );

		// Parse Reponse
		var apiResponse = {};
		apiResponse[ 'responseTime' ] = getTickCount() - requestStart;
		apiResponse[ 'responseHeaders' ] = rawResponse.responseheader;
		apiResponse[ 'statusCode' ] = listFirst( rawResponse.statuscode, ' ' );
		apiResponse[ 'statusText' ] = listRest( rawResponse.statuscode, ' ' );
		apiResponse[ 'rawData' ] = rawResponse.filecontent;
		apiResponse[ 'httpArgs' ] = httpArgs;
		
		// Parse Errors
		if (rawResponse.header is '') {
			apiResponse[ 'error' ] = {};
			apiResponse[ 'error' ].error = rawResponse.filecontent;
	 		apiResponse[ 'error' ].message = rawResponse.errordetail;
		}
	
		return apiResponse;
	}

}