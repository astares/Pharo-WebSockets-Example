Class {
	#name : 'WSEChatHandler',
	#superclass : 'Object',
	#instVars : [
		'webSockets',
		'lock'
	],
	#category : 'Websocket-Example-Server',
	#package : 'Websocket-Example',
	#tag : 'Server'
}

{ #category : 'registration' }
WSEChatHandler >> distributeMessage: message [ 
	"Send message to all client WebSockets that we know."
	
	lock critical: [
		webSockets do: [ :each |
			[ each sendMessage: message ]
				on: NetworkError 
				do: [ :exception |
					"We can ignore this (instead of #unregister:-ing the offender), 
					since the listener process (see #value:) will do the right thing" 
					each logGeneric: exception printString, ' in distributeMessage, ignoring' ] ] ]
]

{ #category : 'initialization' }
WSEChatHandler >> initialize [
	super initialize.
	webSockets := OrderedCollection new.
	lock := Mutex new
]

{ #category : 'registration' }
WSEChatHandler >> register: clientWebSocket [
	lock critical: [
		webSockets add: clientWebSocket ]
]

{ #category : 'registration' }
WSEChatHandler >> unregister: clientWebSocket [
	lock critical: [
		webSockets remove: clientWebSocket ifAbsent: [ ] ]
]

{ #category : 'registration' }
WSEChatHandler >> value: webSocket [
	"I implement a simple chat room service as a server:
	distributing incoming messages to all known clients"
	
	[
		self register: webSocket.
		webSocket runWith: [ :message |
			webSocket logGeneric: 'Received message: ', message printString.
			self distributeMessage: message ] ] 
		on: NetworkError 
		do: [
			webSocket logGeneric: 'Network error, cleaning up'.
			self unregister: webSocket ]
]
