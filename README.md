# cfwheelsreadme-docs-parser

An experimental parser to get CFWheels docs off readme.io and convert them into local html + json
Naturally, this will break quite easily if/when readme.io change their syntax dramatically. Uses JSOUP to parse HTML. FYI This is hardcoded towards v2 of the docs. Only tested on lucee.

## Usage

Clone or download the repo. In commandbox, navigate to the root and just do `server start`.

If there's no `content.json` or `docs.json` in the `/cache/` folder, it'll attempt to go and parse them.

Or you can force it to reparse using `http://127.0.0.1:PORT/?reload=&refetch=`

## Screenshots

![alt tag](http://static.oxalto.co.uk/cfwheelsreadme-docs-parser1.png)

![alt tag](http://static.oxalto.co.uk/cfwheelsreadme-docs-parser2.png)
