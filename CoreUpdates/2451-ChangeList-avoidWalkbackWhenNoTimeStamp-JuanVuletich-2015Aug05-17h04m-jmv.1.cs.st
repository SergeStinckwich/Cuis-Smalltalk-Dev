'From Cuis 4.2 of 25 July 2013 [latest update: #2449] on 5 August 2015 at 5:04:27.207152 pm'!

!ChangeList methodsFor: 'menu actions' stamp: 'jmv 8/5/2015 16:27'!
selectMethodsOlderThanCurrent
	"Selects all method definitions for which there is some newer counterpart in the current image.
	This is, select methods that installing would be go back in time"

	| cm doSelect change class |
	1 to: changeList size do: [ :i | 
		change _ changeList at: i.
		doSelect _ false.
		((change changeType == #method and: [ change isMethodDeletion not ] ) and: [
			((class _ change changeClass) notNil)]) ifTrue: [ | current |
				cm _ class compiledMethodAt: change methodSelector ifAbsent: nil.
				current _ cm ifNotNil: [ cm dateAndTime ].
				current ifNotNil: [ 
					doSelect _ change dateAndTime ifNil: [true] ifNotNil: [ :dateAndTime | dateAndTime < current ]]].
		listSelections at: i put: doSelect ].
	self changed: #allSelections.
	self changed: #annotation! !

