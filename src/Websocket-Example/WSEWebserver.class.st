"
The Webserver
"
Class {
	#name : 'WSEWebserver',
	#superclass : 'Object',
	#instVars : [
		'server'
	],
	#classVars : [
		'Default'
	],
	#category : 'Websocket-Example-Server',
	#package : 'Websocket-Example',
	#tag : 'Server'
}

{ #category : 'accessing' }
WSEWebserver class >> default [
	<sampleInstance>

	^ Default ifNil: [ Default := self new ]
]

{ #category : 'operating' }
WSEWebserver class >> open [
	<script>
	
	WebBrowser openOn: 'http://localhost:8080/'
]

{ #category : 'utilities' }
WSEWebserver class >> openButton [
	<script>

	SimpleButtonMorph new
		color: Color blue muchLighter;
		position: 100@100;
		target: self;
		label: 'Browse';
		extent: 100@100;
		actionSelector: #open;
		openInWorld
]

{ #category : 'class initialization' }
WSEWebserver class >> reset [
	<script>
	self default stop.
	Default := nil 
]

{ #category : 'operating' }
WSEWebserver class >> start [
	<script>
	
	self default start
]

{ #category : 'operating' }
WSEWebserver class >> stop [
	<script>
	
	self default stop
]

{ #category : 'resources' }
WSEWebserver >> indexHTML [ 

	^'<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Websockets</title>
    <script type="text/javascript" src="websocket.js"></script>
</head>
    Name:&nbsp;<input id="name"> 
    Nachricht:&nbsp;<input id="inputtext"> 
    <input type="button" value="Sende" onclick="send()">
    <div id="outputtext"></div>
</body>
</html>'
]

{ #category : 'private - initialization' }
WSEWebserver >> initServer [

	| customDelegate |
	server := ZnServer startDefaultOn: 8080.
	customDelegate := ZnDefaultServerDelegate empty.
		customDelegate
			map: '/' to: 'index.html';
			map: 'index.html' to: [:request | ZnResponse ok: (ZnEntity html: self indexHTML) ];
			map: 'websocket.js' to: [:request | ZnResponse ok: (ZnEntity js: self websocketJS) ];
			map: 'chat' to: (ZnWebSocketDelegate map: 'chat' to: WSEChatHandler new)
			.
	server delegate: customDelegate.
]

{ #category : 'initialization' }
WSEWebserver >> initialize [ 

	super initialize.
	self initServer 	
]

{ #category : 'operating' }
WSEWebserver >> start [
	<script: 'self start'>

	server start

]

{ #category : 'operating' }
WSEWebserver >> stop [
	<script: 'self stop'>
	
	server stop

]

{ #category : 'resources' }
WSEWebserver >> websocketJS [ 

	^'var websocket = 
   new WebSocket(
        "ws://" +
        document.location.host + 
        document.location.pathname + 
        "chat");

// when connection is open
websocket.onopen = function onOpen() {
    var p = document.createElement("p");
    p.innerHTML = "Verbunden!";
    document.getElementById("outputtext").appendChild(p); 
}

websocket.onmessage= function onmessage(evt) {
    var p = document.createElement("p");
    p.innerHTML = evt.data;
    document.getElementById("outputtext").appendChild(p); 
}

function send() {
    console.log(websocket.readyState);
    if(websocket.readyState != 1) { return } // 1 = OPEN
    var name = document.getElementById("name");
    var inputtext = document.getElementById("inputtext");
    websocket.send(name.value + ": " + inputtext.value);
}'
]
