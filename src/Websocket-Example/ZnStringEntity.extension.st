Extension { #name : 'ZnStringEntity' }

{ #category : '*Websocket-Example' }
ZnStringEntity class >> js: string [

	^ (self type: ZnMimeType textJavascript)
		string: string;
		yourself
]
