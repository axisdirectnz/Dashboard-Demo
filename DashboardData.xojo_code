#tag Class
Protected Class DashboardData
Inherits Timer
	#tag Event
		Sub Action()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Refreshes the data & sends updates to the Observers                                          \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  mDataChanged = False
		  
		  If mDate <> DateTime.Now.DatePart Then ' The time has passed midnight so reload the history for a new day
		    HistoryData()
		    mDataChanged = True
		  End If
		  
		  DynamicData() ' Collect the data
		  
		  If mDataChanged Then ' Update the Observers if the data has changed
		    For Each Observer As dataNotificationReceiver In mObservers
		      Observer.dataChanged
		    Next Observer
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddDataNotificationReceiver(Receiver As dataNotificationReceiver)
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Observers register themselves here                                                           \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  mObservers.Add(Receiver)
		  
		  Timer.CallLater(0, AddressOf Receiver.dataChanged)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChartLabels() As String()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Returns the Private Property Chartlabels. Called by Observers.                               \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Return mChartLabels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChartValues() As Double()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Returns the Private Property ChartValues. Called by Observers.                                                                                             \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Return mChartValues
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Chunks() As Integer
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Returns the Private Property ChunkCoiunt. Called by Observers.                                                                                             \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Return mChunks
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Initilises the Object. It is private because this Object is a Singleton.                     \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  HistoryData()
		  
		  DynamicData()
		  
		  me.Period = 1000
		  me.RunMode = Timer.RunModes.Multiple
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DynamicData()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Initilises the Object. It is private because this Object is a Singleton.                     \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Var Rows As RowSet
		  
		  // Load Today's values
		  Rows = App.db.SelectSQL("SELECT COUNT(Chunks) As MessageCount, SUM(Chunks) AS ChunkCount FROM Processed WHERE DateSent > ?;", DateTime.Now.DatePart)
		  
		  If mMessages <> Rows.Column("MessageCount").IntegerValue Then
		    mMessages = Rows.Column("MessageCount").IntegerValue
		    mChunks = Rows.Column("ChunkCount").IntegerValue
		    mChartValues(mChartValues.LastIndex) = Rows.Column("ChunkCount").DoubleValue
		    mDataChanged = True
		  End If
		  
		  Rows = App.db.SelectSQL("SELECT COUNT(Chunks) AS QueueLength FROM Queue;")
		  If mQueueLength <> Rows.Column("QueueLength").IntegerValue Then
		    mQueueLength = Rows.Column("QueueLength").IntegerValue
		    mDataChanged = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetInstance() As DashboardData
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Returns the Instance of Dashboard Data. This is a Singleton Class.                           \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  If mInstance Is Nil Then
		    mInstance = New DashboardData
		  End If
		  
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HistoryData()
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Sets up the history data for the Observing Chart.                                            \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  // History Data
		  mChartLabels.RemoveAll
		  mChartValues.RemoveAll
		  
		  Var Rows As RowSet
		  // Get last 28 days data from Statistics table.  This will result in 27 days of data because there isn't a record for today.
		  Var StartDate As DateTime = DateTime.Now.DatePart.SubtractInterval(0, 0, 28)
		  Rows = App.db.SelectSQL("SELECT * FROM Statistics WHERE ProcessingDate > ? ORDER BY ProcessingDate;", StartDate)
		  
		  For Each Row As DatabaseRow In Rows
		    mChartLabels.Add(Rows.Column("ProcessingDate").DateTimeValue.ToString(DateTime.FormatStyles.Short, DateTime.FormatStyles.None))
		    mChartValues.Add(Rows.Column("ChunkCount").DoubleValue)
		  Next Row
		  
		  // Add label for today
		  mChartLabels.Add(DateTime.Now.DatePart.ToString(DateTime.FormatStyles.Short, DateTime.FormatStyles.None))
		  mChartValues.Add(0.)
		  
		  mDate = DateTime.Now.DatePart ' Save the current date so a date change can be detected
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Messages() As Integer
		  // Part of the DashboardInterface interface.
		  
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Returns the Private Property Messages.  Called by Observers.                                 \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Return mMessages
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QueueLength() As Integer
		  // Part of the DashboardInterface interface.
		  
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Returns the Private Property QueueLength. Called by Observers.                               \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  Return mQueueLength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveDataNotificationReceiver(Receiver As dataNotificationReceiver)
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : Observers de-register themselves here.                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  For i As Integer = 0 To mObservers.LastIndex ' Loop through the observers
		    If mObservers(i) = receiver Then ' Whenthe receiver is found
		      mObservers.RemoveAt(i) ' Remove it from the array
		      If mObservers.Count = 0 Then ' There are no Observers, so destroy this instance.
		        mInstance = Nil
		      End If
		      Return ' The Observer has been found so no need to look further
		    End If
		  Next i
		  
		  // NB: For a busy site you would not destroy the instance, but stop & start the timer
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mChartLabels() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChartValues() As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChunks As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDataChanged As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDate As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As DashboardData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessages As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers() As dataNotificationReceiver
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueueLength As Integer
	#tag EndProperty


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Class
#tag EndClass
