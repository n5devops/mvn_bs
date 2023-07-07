<html>
<head>
  <title>Book Query</title>
</head>
<body>
  <h1>Academy E-Bookstore</h1>
  <h3>Choose Author(s):</h3>
  <form method="get">
          <input type="checkbox" name="author" value="Tolstoy">Tolstoy<br>
          <input type="checkbox" name="author" value="Shakespear">Shakespear<br>
          <input type="checkbox" name="author" value="Agatha">Agatha Christie<br>
          <input type="checkbox" name="author" value="Rowling">J K Rowling<br><br>
          <input type="submit" value="List the Books and Price"><br>
  </form>

  <%
    String[] authors = request.getParameterValues("author");
    if (authors != null) {
  %>
  <%@ page import = "java.sql.*" %>
  <%
      // build the jdbc url

      // Read RDS connection information from the environment
      String dbName = System.getProperty("RDS_DB_NAME");
      String userName = System.getProperty("RDS_USERNAME");
      String password = System.getProperty("RDS_PASSWORD");
      String hostname = System.getProperty("RDS_HOSTNAME");
      String port = System.getProperty("RDS_PORT");
      String jdbcUrl = "jdbc:mysql://" + hostname + ":" +
        port + "/" + dbName + "?user=" + userName + "&password=" + password;

      // Load the JDBC driver
      try {
        System.out.println("Loading driver...");
        Class.forName("com.mysql.jdbc.Driver");
        System.out.println("Driver loaded!");
      } catch (ClassNotFoundException e) {
        throw new RuntimeException("Cannot find the driver in the classpath!", e);
      }

      Connection conn = null;
      Statement setupStatement = null;
