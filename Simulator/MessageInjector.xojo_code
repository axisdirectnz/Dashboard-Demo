#tag Class
Protected Class MessageInjector
Inherits Timer
	#tag Event
		Sub Action()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Inserts "messages" of varying length into the queue.                                         \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Var r As New Random
		  
		  Var sql As String = "INSERT INTO Queue (Chunks) VALUES (?);"
		  
		  Var Rows As RowSet = App.db.SelectSQL("SELECT COUNT(Chunks) AS QLength FROM Queue;")
		  If Rows.Column("QLength").IntegerValue > 200 Then
		    Return
		  End If
		  
		  Var Count As Integer = r.InRange(50, 1000)
		  
		  For i As Integer = 1 To Count
		    App.db.ExecuteSQL(sql, r.InRange(1, 3))
		  Next i
		  
		  me.Period = 60000
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Initialises the Timer Runtime parameters                                                     \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  me.Period = 100
		  me.RunMode = Timer.RunModes.Multiple
		  
		End Sub
	#tag EndMethod


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
			InitialValue=""
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
			Name="RunMode"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="RunModes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Off"
				"1 - Single"
				"2 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
