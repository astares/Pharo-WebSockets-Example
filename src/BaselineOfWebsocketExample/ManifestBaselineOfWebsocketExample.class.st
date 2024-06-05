"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestBaselineOfWebsocketExample',
	#superclass : 'PackageManifest',
	#category : 'BaselineOfWebsocketExample-Manifest',
	#package : 'BaselineOfWebsocketExample',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestBaselineOfWebsocketExample class >> ruleClassNotReferencedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#BaselineOfWebSocketExample)) #'2024-06-05T23:49:40.94051+02:00') )
]
