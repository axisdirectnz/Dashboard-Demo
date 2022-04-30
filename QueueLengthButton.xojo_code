#tag Class
Protected Class QueueLengthButton
Inherits WebButton
Implements dataNotificationReceiver
	#tag Event
		Sub Closed()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : The WebPage is being destroyed, so de-register this Observer.                                \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  mSubject.RemoveDataNotificationReceiver(me)
		  mSubject = Nil
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : The WebPage is being shown, so register this Observer.                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  mSession = Session ' This is required so the Dashboard Data instance can update the Observing Control
		  
		  mSubject = DashboardData.GetInstance() ' Get a reference to the DashboardData Instance
		  
		  mSubject.addDataNotificationReceiver(Me) ' Register as an Observer
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub dataChanged()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Called From the DashboardData Instance                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  // Set the Session Context - this tells the framework which session this control belongs to
		  Var Context As New WebSessionContext(mSession)
		  #Pragma Unused Context
		  
		  // Update the Caption of the Control
		  me.Caption = "There are " + If(mSubject.QueueLength = 0, "no", mSubject.QueueLength.ToString) + " messages in the queue"
		  
		  // Set the color of the button depending on the number of items in the queue
		  Select Case mSubject.QueueLength
		  Case Is < 200
		    me.Indicator = Indicators.Success
		  Case Is > 500
		    me.Indicator = Indicators.Danger
		  Case Else
		    me.Indicator = Indicators.Warning
		  End Select
		  
		  // And send the update to the browser.
		  UpdateBrowser
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSession As WebSession
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubject As DashboardData
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
		#tag ViewProperty
			Name="Indicator"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="WebUIControl.Indicators"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Primary"
				"2 - Secondary"
				"3 - Success"
				"4 - Danger"
				"5 - Warning"
				"6 - Info"
				"7 - Light"
				"8 - Dark"
				"9 - Link"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ControlID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Behavior"
			InitialValue="34"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Behavior"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDisable"
			Visible=true
			Group="Button"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Cancel"
			Visible=true
			Group="Button"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=true
			Group="Button"
			InitialValue="Untitled"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Default"
			Visible=true
			Group="Button"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
