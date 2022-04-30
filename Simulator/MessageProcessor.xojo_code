#tag Class
Protected Class MessageProcessor
Inherits Timer
	#tag Event
		Sub Action()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Processes the "messages" in the Queue by moving them to the Processed table.                 \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Var Rows As RowSet
		  Rows = App.db.SelectSQL("SELECT COUNT(8) AS ql FROM Queue;")
		  If Rows.Column("ql").IntegerValue > 0 Then
		    stdout.WriteLine("Queue Length = " + Rows.Column("ql").IntegerValue.ToString)
		  End If
		  
		  Rows = App.db.SelectSQL("SELECT * FROM Queue;")
		  
		  If Rows.AfterLastRow Then
		    Return
		  End If
		  
		  App.db.ExecuteSQL("INSERT INTO Processed (DateSent, Chunks) VALUES (?, ?);", DateTime.Now.SQLDateTime, Rows.Column("Chunks").IntegerValue)
		  App.db.ExecuteSQL("DELETE FROM Queue WHERE ID = ?;", Rows.Column("ID").IntegerValue)
		  
		  
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
		  
		  me.Period = 250
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
