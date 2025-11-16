Subject No. 25

A restaurant management system enables management staff, sale staff and customers to use:
- Management staff: view statistics: dishes, ingredients, customers and suppliers. Manage dish information, make combo menus.
Warehouse staff: import materials from suppliers, manage supplier information
- Sale staff: receive customers, take orders, receive payments at the table, make membership cards for customers, confirm table reservation information and order online.
- Customer: search, book a table and order food online.

Considering two  modules:
- Management staff edits dish information: selects the menu to manage dish information → selects the function to edit dish information → searches for dishes by name to edit → selects dishes from the list of results to edit → enters information dishes and clicks save → saves to the database.
- Management staff view supplier statistics: selects the menu to view the statistical report → selects the supplier statistics according to the imported quantity → selects the start and end time of statistics → views supplier statistics → selects a supplier view details → views list of imported invoice of the supplier → selects view 1 imported invoice → views the detail of selected imported invoice.

Restaurant Management System:
 
- Technology
- Backend: Java Servlet, JSP
- Database: MySQL
- Server: Apache Tomcat 9.x
- Build Tool: Maven

- Directory structure
src/main/
  java/com/restaurant/
    model             # Entity classes
    dao               # DAO
    servlet           # Controller
  webapp/             # JSP views
    css/
    *.jsp
├── java/com/restaurant/
│   ├── model/          # Entity classes
│   ├── dao/            # Data Access Object
│   └── servlet/        # Controller
└── webapp/             # JSP views
    ├── css/
    └── *.jsp



