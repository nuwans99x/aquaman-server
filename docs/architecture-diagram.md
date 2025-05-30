# System Architecture Diagram

```
+---------------------+         REST API         +-----------------------------+      SQL Connector      
|                     | <---------------------> |                             | <---------------------> |
|   React Client      |                         |   .NET Core Server          |                         |
|   (Frontend)        |                         |   (Web API)                 |                         |
+---------------------+                         +-----------------------------+                         |
                                                                                                     |
                                                                                                     |
                                                                                                 +-------------------+
                                                                                                 | Azure SQL DB      |
                                                                                                 +-------------------+
```

- The React client communicates with the .NET Core REST API.
- The .NET Core server manages business logic and handles identity internally using the same Azure SQL database.
- The Azure SQL database stores both application data and user identity information.
