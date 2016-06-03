package Test;

import model.MyConnection;
import java.sql.*;
import java.util.Vector;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;


public class TestConnection {
	public static void main(String[] args) {
		MyConnection myConnection = new MyConnection();
		ResultSet rs = myConnection.execute("select per_cedula from empleado join persona using (per_id) ");
		try {

			JTable table = new JTable(buildTableModel(rs));
			JOptionPane.showMessageDialog(null, new JScrollPane(table));
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	public static DefaultTableModel buildTableModel(ResultSet rs)
	        throws SQLException {

	    ResultSetMetaData metaData = rs.getMetaData();

	    // names of columns
	    Vector<String> columnNames = new Vector<String>();
	    int columnCount = metaData.getColumnCount();
	    for (int column = 1; column <= columnCount; column++) {
	        columnNames.add(metaData.getColumnName(column));
	    }
	    // data of the table
	    Vector<Vector<String>> data = new Vector<Vector<String>>();
	    while (rs.next()) {
	        Vector<String> vector = new Vector<String>();
	        for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
	            vector.add(rs.getString(columnIndex));
	        }
	        data.add(vector);
	    }
	    return new DefaultTableModel(data, columnNames);
	}
}
