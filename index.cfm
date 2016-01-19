<cfsetting requesttimeout="180">
<cfscript>
testSuite = createObject("component","mxunit.framework.TestSuite").TestSuite();
testSuite.addAll("test.testAPI");
testSuite.addAll("test.testContact"); 
testSuite.addAll("test.testJourney"); 
testSuite.addAll("test.testList"); 

results = testSuite.run();
</cfscript>


<cfoutput>
<!DOCTYPE HTML>

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>AutopilotHQ ColdFusion API Wrapper</title>
		<link rel="stylesheet" type="text/css" href="/mxunit/resources/theme/styles.css">
			<link rel="stylesheet" type="text/css" href="/mxunit/resources/jquery/tablesorter/green/style.css">
			<link rel="stylesheet" type="text/css" href="/mxunit/resources/theme/results.css">
			<link rel="stylesheet" type="text/css" href="/mxunit/resources/jquery/tipsy/stylesheets/tipsy.css">

			<script type="text/javascript" src="/mxunit/resources/jquery/jquery.min.js"></script>
			<script type="text/javascript" src="/mxunit/resources/jquery/jquery-ui.min.js"></script>
			<script type="text/javascript" src="/mxunit/resources/jquery/jquery.sparkline.min.js"></script>
			<script type="text/javascript" src="/mxunit/resources/jquery/tablesorter/jquery.tablesorter.js"></script>
			<script type="text/javascript" src="/mxunit/resources/jquery/tipsy/javascripts/jquery.tipsy.js"></script>
			<script type="text/javascript" src="/mxunit/resources/jquery/jquery.runner.js"></script>

	<style>
	.center {
    margin: auto;
    width: 60%;
    border: 3px solid ##73AD21;
    padding: 10px;
}
	</style>

</head>


<div style="width:1000px" class="center">

<h1>AutopilotHQ Cold Fusion API Wrapper</h1>


#results.getResultsOutput('rawhtml')#

</div>
</body>

</cfoutput>
