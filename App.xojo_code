#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Opening(args() as String)
		  //************************************************************************************************************\\
		  // Author      : W Golding                                                                                    \\
		  //                                                                                                            \\
		  // Date        : 23/02/2022                                                                                   \\
		  //                                                                                                            \\
		  // Description : The application is starting                                                                   \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  // Modification History                                                                                       \\
		  //                                                                                                            \\
		  //************************************************************************************************************\\
		  
		  #Pragma Unused args
		  
		  // The following lines of code create an inmemory sqlite database and create history to be shown in the chart
		  // these lines would NOT be included in a live environment.
		  Var r As New Random
		  
		  db = New SQLiteDatabase
		  db.Connect
		  db.ExecuteSQL("CREATE TABLE Statistics (ProcessingDate DATE NOT NULL PRIMARY KEY, MessageCount INT NOT NULL, ChunkCount INT NOT NULL);")
		  db.ExecuteSQL("CREATE TABLE Queue (ID INTEGER PRIMARY KEY AUTOINCREMENT, Chunks INT NOT NULL);")
		  db.ExecuteSQL("CREATE TABLE Processed (ID INTEGER PRIMARY KEY AUTOINCREMENT, DateSent DATE NOT NULL, Chunks INT NOT NULL);")
		  
		  // Create Stats (Chart History)
		  Var sql As String = "INSERT INTO Statistics (ProcessingDate, MessageCount, ChunkCount) VALUES (?, ?, ?);"
		  For i As Integer = -27 To -1
		    Var MessageCount As Integer = r.InRange(500, 2000)
		    Var PartCount As Integer = r.InRange(MessageCount, MessageCount * 3)
		    db.ExecuteSQL(sql, DateTime.Now.DatePart.AddInterval(0, 0, i), MessageCount, PartCount)
		  Next i
		  
		  Simulator.Initialise() ' Run the simulator
		  
		End Sub
	#tag EndEvent


	#tag Note, Name = ReadMe
		You can alter the speed of refresh by changing the period in the DashboardData.Constructor Method
		
		Watch the XDC Session about this project at https://www.youtube.com/watch?v=NeNJU5eTL3w
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		db As SQLiteDatabase
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
