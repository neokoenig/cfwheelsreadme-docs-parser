<cfscript>
  docs=deserializeJSON(fileRead("cache/docs.json"));
  content=deserializeJSON(fileRead("cache/content.json"));
  c=1;
</cfscript>
<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title>Docs</title>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<script
	  src="https://code.jquery.com/jquery-2.2.4.min.js"
	  integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	  crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
<h1>CFWheels Docs</h1>
<p>
<div class="btn-group">
	<a href="?reload" class="btn btn-primary btn-xs">Reload</a>
	<a href="?reload=&refetch=" class="btn btn-warning btn-xs">Refetch</a>
</div></p>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="false">
<cfloop array="#docs.reference#" index="doc">
 <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="api#c#">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="##accordion" href="##collapse#c#" aria-expanded="false" aria-controls="collapse#c#">
          #doc.Title#
        </a>
      </h4>
    </div>
    <div id="collapse#c#" class="panel-collapse collapse" role="tabpanel" aria-labelledby="api#c#">
      <div class="panel-body">
      	<div class="well well-small">
	      	<div class="row">
	      		<div class="col-md-3">Reference: #doc.Category#</div>
	      		<div class="col-md-3">Slug: #doc.Slug#</div>
	      		<div class="col-md-3"><i class="glyphicon glyphicon-link"></i> <a href="http://docs.cfwheels.org/v2.0/reference###doc.slug#">Link</a></div>
	      		<div class="col-md-3"></div>
	      	</div>
      	</div>
        #content[c]#
      </div>
    </div>
  </div>
  <cfset c++>
</cfloop>
</div>
</body>
</html>

</cfoutput>
