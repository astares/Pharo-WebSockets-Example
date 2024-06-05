"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestWebsocketExample',
	#superclass : 'PackageManifest',
	#category : 'Websocket-Example-Manifest',
	#package : 'Websocket-Example',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestWebsocketExample class >> ruleClassNotReferencedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#WSEWebserver)) #'2024-06-05T23:36:53.959432+02:00') )
]
