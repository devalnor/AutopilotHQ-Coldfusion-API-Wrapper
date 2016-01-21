component {

	variables.config={};
	variables.config.apikey="";
	variables.config.defaultserviceUrl="api2.autopilothq.com/v1/";    

	public any function init(
		required string apikey,
				 string serviceUrl = variables.config.defaultserviceUrl
		) {

		// If empty serviceUrl, force the default one
		if (arguments.serviceUrl is "") {arguments.serviceUrl = variables.config.defaultserviceUrl;}

		// Save the Api Key
		variable.config.apikey = arguments.apikey;

		// Save the serviceUrl
		variable.config.serviceUrl = arguments.serviceUrl;

		// Init components
		var utils = new utils();
		var api = new api(variable.config.apikey,variable.config.serviceUrl, utils);

		var autopilot = {};
		autopilot['contact'] = new contact(api,utils);
		autopilot['journey'] = new journey(api,utils);
		autopilot['list'] = new list(api,utils);

		return autopilot;
	}

}