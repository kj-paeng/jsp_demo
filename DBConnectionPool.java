package javacan.db.pool;

/**
*/

import java.sql.*;
import java.util.*;

public class DBConnectionPool {
	private int checkedOut;
	private Vector freeConnections = new Vector();
	private int maxConn;
	private String name;
	private String password;
	private String URL;
	private String user;
	
	public static final int DEFAULT_MAX_CON = 50;

	public DBConnectionPool(String name, String URL,
					 String user, String password, int maxConn) {
		this.name = name;
		this.URL = URL;
		this.user = user;
		this.password = password;
		this.maxConn = maxConn;
		
		if ( this.maxConn <= 0 ) {
			this.maxConn = DEFAULT_MAX_CON;
		}
	}

	public synchronized Connection getConnection() throws DBPoolException {
		Connection conn = null;
		
		while( freeConnections.size() <= 0 ) {
			if ( checkedOut < maxConn ) {
				conn = newConnection();
				break;
			}
			try {
				// ����Ǿ� �ִ� Connection�� ���� ���
				// Connection�� ��ȯ�� �� ���� ��ٸ���.
				wait();
			} catch(InterruptedException ex) {}
		}
		
		if ( conn == null ) {
			conn = (Connection) freeConnections.firstElement();
			freeConnections.removeElementAt(0);
			
			try {
				if ( conn.isClosed() ) {
					conn = newConnection();
				}
			} catch(SQLException ex) {
				conn = newConnection();
			}
		}
		if (conn != null) {
			checkedOut++;
		} else {
			throw new DBPoolException("Can't obtain DB Connection!");
		}
		return conn;
	}
	
	private Connection newConnection() {
		Connection conn = null;
		try {
			if (user == null) {
				conn = DriverManager.getConnection(URL);
			} else {
				conn = DriverManager.getConnection(URL, user, password);
			}
		} catch (SQLException ex) {
			return null;
		}
		return conn;
	}
	
	public synchronized void returnConnection(Connection conn) {
		// Connection�� Vector�� �� �������� �����Ѵ�.
		freeConnections.addElement(conn);
		checkedOut--;
		notifyAll();
	}
	
	public synchronized void close() {
		Enumeration allConnections = freeConnections.elements();
		while (allConnections.hasMoreElements()) {
			Connection conn = (Connection) allConnections.nextElement();
			try {
				conn.close();
			} catch (SQLException ex) { }
		}
		freeConnections.removeAllElements();
	}
}
