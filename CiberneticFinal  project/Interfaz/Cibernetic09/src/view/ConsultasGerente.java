package view;

import javax.swing.JFrame;

import java.awt.Color;

import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.SwingConstants;

import java.awt.Font;

import javax.swing.JButton;
import javax.swing.JTextField;

import Test.TestConnection;
import model.MyConnection;

import java.awt.SystemColor;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConsultasGerente extends JFrame {
	private JTextField textField;
	private JTextField textField_1;
	private JTextField textField_2;
	public ConsultasGerente() {
		setTitle("Consultas");
		getContentPane().setBackground(new Color(95, 158, 160));
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(105, 105, 105));
		panel.setBounds(0, 0, 684, 66);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Consultas");
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 32));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(0, 0, 684, 66);
		panel.add(lblNewLabel);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBackground(new Color(50, 205, 50));
		panel_1.setBounds(0, 63, 233, 249);
		getContentPane().add(panel_1);
		panel_1.setLayout(null);
		
		JPanel panel_3 = new JPanel();
		panel_3.setBackground(new Color(0, 100, 0));
		panel_3.setBounds(0, 0, 233, 73);
		panel_1.add(panel_3);
		panel_3.setLayout(null);
		
		JLabel lblNewLabel_1 = new JLabel("Clientes");
		lblNewLabel_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 27));
		lblNewLabel_1.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_1.setBounds(0, 0, 233, 73);
		panel_3.add(lblNewLabel_1);
		
		JButton btnNewButton = new JButton("Mejores Clientes");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs = my.execute("select * from goodClients");
				JTable table;
				try {
					table = new JTable(TestConnection.buildTableModel(rs));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, e1);
				}	
			}
		});
		btnNewButton.setForeground(new Color(255, 255, 255));
		btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 19));
		btnNewButton.setBackground(new Color(105, 105, 105));
		btnNewButton.setBounds(26, 84, 185, 35);
		panel_1.add(btnNewButton);
		
		JLabel lblNewLabel_2 = new JLabel("C\u00E9dula");
		lblNewLabel_2.setFont(new Font("Tahoma", Font.PLAIN, 17));
		lblNewLabel_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_2.setBounds(26, 130, 93, 23);
		panel_1.add(lblNewLabel_2);
		
		textField = new JTextField();
		textField.setFont(new Font("Tahoma", Font.PLAIN, 15));
		textField.setBounds(26, 153, 185, 29);
		panel_1.add(textField);
		textField.setColumns(10);
		
		JButton btnBuscar = new JButton("Buscar!");
		btnBuscar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs= my.execute("call consultarCliente(" + textField.getText() + ")");
				JTable table;
				try {
					table = new JTable(TestConnection.buildTableModel(rs));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, e1);
				}
			}
		});
		btnBuscar.setForeground(Color.WHITE);
		btnBuscar.setFont(new Font("Tahoma", Font.PLAIN, 21));
		btnBuscar.setBackground(SystemColor.controlDkShadow);
		btnBuscar.setBounds(26, 193, 185, 35);
		panel_1.add(btnBuscar);
		
		JPanel panel_2 = new JPanel();
		panel_2.setBackground(new Color(169, 169, 169));
		panel_2.setBounds(451, 63, 233, 249);
		getContentPane().add(panel_2);
		panel_2.setLayout(null);
		
		JPanel panel_6 = new JPanel();
		panel_6.setBackground(new Color(47, 79, 79));
		panel_6.setBounds(0, 0, 233, 73);
		panel_2.add(panel_6);
		panel_6.setLayout(null);
		
		JLabel lblProveedores_1 = new JLabel("Proveedores");
		lblProveedores_1.setHorizontalAlignment(SwingConstants.CENTER);
		lblProveedores_1.setForeground(Color.WHITE);
		lblProveedores_1.setFont(new Font("Tahoma", Font.PLAIN, 27));
		lblProveedores_1.setBounds(0, 0, 233, 73);
		panel_6.add(lblProveedores_1);
		
		JLabel label_1 = new JLabel("C\u00E9dula");
		label_1.setForeground(Color.WHITE);
		label_1.setFont(new Font("Tahoma", Font.PLAIN, 17));
		label_1.setBounds(22, 129, 93, 23);
		panel_2.add(label_1);
		
		textField_2 = new JTextField();
		textField_2.setFont(new Font("Tahoma", Font.PLAIN, 15));
		textField_2.setColumns(10);
		textField_2.setBounds(22, 152, 185, 29);
		panel_2.add(textField_2);
		
		JButton button_1 = new JButton("Buscar!");
		button_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs= my.execute("call consultarProveedorw(" + textField_2.getText() + ")");
				JTable table;
				try {
					table = new JTable(TestConnection.buildTableModel(rs));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, e1);
				}
			}
		});
		button_1.setForeground(Color.WHITE);
		button_1.setFont(new Font("Tahoma", Font.PLAIN, 21));
		button_1.setBackground(SystemColor.controlDkShadow);
		button_1.setBounds(22, 192, 185, 35);
		panel_2.add(button_1);
		
		JPanel panel_4 = new JPanel();
		panel_4.setBackground(new Color(0, 139, 139));
		panel_4.setBounds(233, 63, 233, 73);
		getContentPane().add(panel_4);
		panel_4.setLayout(null);
		
		JLabel lblProveedores = new JLabel("Empleados");
		lblProveedores.setHorizontalAlignment(SwingConstants.CENTER);
		lblProveedores.setForeground(Color.WHITE);
		lblProveedores.setFont(new Font("Tahoma", Font.PLAIN, 27));
		lblProveedores.setBounds(0, 0, 223, 73);
		panel_4.add(lblProveedores);
		
		JLabel label = new JLabel("C\u00E9dula");
		label.setForeground(Color.WHITE);
		label.setFont(new Font("Tahoma", Font.PLAIN, 17));
		label.setBounds(243, 191, 93, 23);
		getContentPane().add(label);
		
		textField_1 = new JTextField();
		textField_1.setFont(new Font("Tahoma", Font.PLAIN, 15));
		textField_1.setColumns(10);
		textField_1.setBounds(243, 214, 185, 29);
		getContentPane().add(textField_1);
		
		JButton button = new JButton("Buscar!");
		button.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs= my.execute("call consultarEmpleadow(" + textField_1.getText() + ")");
				JTable table;
				try {
					table = new JTable(TestConnection.buildTableModel(rs));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, e1);
				}
			}
		});
		button.setForeground(Color.WHITE);
		button.setFont(new Font("Tahoma", Font.PLAIN, 21));
		button.setBackground(SystemColor.controlDkShadow);
		button.setBounds(243, 254, 185, 35);
		getContentPane().add(button);
		setBounds(50,50,700,350);
	}
}
