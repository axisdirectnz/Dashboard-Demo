#tag Module
Protected Module Simulator
	#tag Method, Flags = &h1
		Protected Sub Initialise()
		  
		  Injector = New MessageInjector
		  Processor = New MessageProcessor
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = ReadMe
		This module simulates Data being injected into the database by a third party application.
		
		You can alter the rate of messages being added to the queue by changing the period at the bottom of the MessageInjector.Action Event Handler.
		
		You can alter the speed to processing the messages by changing the period in the MessageProcessor.Constructor Method.
	#tag EndNote


	#tag Property, Flags = &h21
		Private Injector As MessageInjector
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Processor As MessageProcessor
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
