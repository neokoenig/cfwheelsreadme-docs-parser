component {

    this.name = "cfwheelsdoctest";
    this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0); //10 days
    this.sessionManagement = false;
    this.javaSettings = {
        loadPaths: [
            "./lib/"
        ],
        loadColdFusionClassPath: true
    };

    function onApplicationStart() {
        if(structKeyExists(url,"refetch")
            || !fileExists("cache/content.json")
            || !fileExists("cache/docs.json")
        ){
            this.refreshDocs();
            this.refreshContent();
        }
        return true;
    }

    // the target page is passed in for reference,
    // but you are not required to include it
    function onRequestStart( string targetPage ) {}

    function onRequest( string targetPage ) {
    	if(structKeyExists(url,"reload")) this.onApplicationStart();
        include arguments.targetPage;
    }

    function onError( any Exception, string EventName ) {
    	writeDump(exception);
    }

    void function refreshDocs(){
        cfhttp(method="GET",
            charset="utf-8",
            url="http://docs.cfwheels.org/api/mobile/navigation",
            result="local.result") {};
        fileWrite("cache/docs.json", local.result.filecontent);
    }
    void function refreshContent(){
        local.c=1;
        local.rv=[];
        local.jSoupClass = createObject( "java", "org.jsoup.Jsoup" );
        local.dom = jSoupClass.connect( "http://docs.cfwheels.org/reference" ).get();
        local.sections = local.dom.select( "div.hub-reference" );

        for ( s in local.sections ){
            local.header= s.select("> div.hub-reference-section.hub-reference-section-top div.hub-reference-left header h2");
                for(h2 in local.header){
                    h2.tagName("h3");
                }
            local.headerExcerpt= s.select("> div.hub-reference-section div.hub-reference-left header .excerpt");
            local.paramTable= s.select("> div.hub-reference-section div.hub-reference-left div.content-body div.magic-block-parameters div.block-parameters-table");
                local.paramTable.select("div.td");
                for(td in local.paramTable.select("div.td")){
                    td.tagName("td");
                }
                local.paramTable.select("div.th");
                for(th in local.paramTable.select("div.th")){
                    th.tagName("th");
                }
                local.paramTable.select("div.tr");
                for(tr in local.paramTable.select("div.tr")){
                    tr.tagName("tr");
                }
                local.paramTable.select("div.table");
                for(table in local.paramTable.select("div.table")){
                    table.tagName("table");
                }
            local.code=s.select("> div.hub-reference-section div.hub-reference-left div.content-body div.magic-block-code div.block-code-code");

            local.parsed=this.renderSection(local.header, local.headerExcerpt, local.paramTable, local.code);
            if(len(local.parsed)){
                arrayAppend(local.rv,  local.parsed);
            }
            c++;
        }
        fileWrite("cache/content.json", serializeJSON(local.rv));
    }

    string function renderSection(array header, array headerExcerpt, array paramTable, array code){
		savecontent variable="local.rv" {
	    	if(arrayLen(header)){
	    		writeOutput(arrayToList(header));
	    	}
	    	if(arrayLen(headerExcerpt)){
	    		writeOutput(arrayToList(headerExcerpt));
	    	}
	    	if(arrayLen(paramTable)){
	    		writeOutput(arrayToList(paramTable));
	    	}
            if(arrayLen(code)){
                writeOutput(arrayToList(code,"<hr />"));
            }
    	}
    	return local.rv;
	}
}
