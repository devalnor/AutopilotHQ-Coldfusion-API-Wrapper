component {

	variables.config={};
	variables.config.apikey="";
	variables.config.defaultserviceUrl="api2.autopilothq.com/v1/";    

	public any function init(
		required string apikey,
				 string serviceUrl = variables.config.defaultserviceUrl
		) {

		variable.config.apikey = arguments.apikey;
		variable.config.serviceUrl = arguments.serviceUrl;

		var utils = new utils();
		var api = new api(variable.config.apikey,variable.config.serviceUrl, utils);

		var autopilot = {};
		autopilot['contact'] = new contact(api,utils);
		autopilot['journey'] = new journey(api,utils);
		autopilot['list'] = new list(api,utils);

		return autopilot;
	}

}