"
Baseline for [https://github.com/astares/Pharo-WebSockets-Example](https://github.com/astares/Pharo-WebSockets-Example)
"
Class {
	#name : 'BaselineOfWebSocketExample',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfWebsocketExample-Base',
	#package : 'BaselineOfWebsocketExample',
	#tag : 'Base'
}

{ #category : 'baselines' }
BaselineOfWebSocketExample >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		self zinc: spec.
		spec package: #'Websocket-Example' with: [ spec requires: 'ZincHTTPComponentsWebSocket'].
						
		spec 
			group: 'all' with: #('Websocket-Example');
			group: 'default' with: #('all')
	 ]
]

{ #category : 'baselines' }
BaselineOfWebSocketExample >> zinc: spec [

	spec baseline: 'ZincHTTPComponentsWebSocket' with: [
		spec repository: 'github://svenvc/zinc:master/repository' ]
]
