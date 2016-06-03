package view;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JFrame;

import java.awt.Color;
import java.awt.HeadlessException;

import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.SwingConstants;

import java.awt.Font;

import javax.swing.JScrollPane;

import Test.TestConnection;

import javax.swing.JButton;
import javax.swing.JTextField;

import model.MyConnection;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class MarketFrame extends JFrame {
	private JTextField textField;
	private JTextField textField_1;
	private JTable table_1;
	private String id,product,sql;
	private JTextField textField_2;
	public MarketFrame(ResultSet rs, final String sql, final String fecha) {
		this.sql = sql;
		getContentPane().setBackground(new Color(0, 139, 139));
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(105, 105, 105));
		panel.setBounds(0, 0, 784, 71);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Editar Mercado dia "+fecha);
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 29));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(0, 0, 784, 71);
		panel.add(lblNewLabel);
		
		JTable table = null;
		try {
			table_1 = new JTable(TestConnection.buildTableModel(rs));
			table_1.addMouseListener(new MouseAdapter() {
				
				@Override
				public void mouseClicked(MouseEvent e) {
					int row = table_1.getSelectedRow();
					String s1 = table_1.getModel().getValueAt(row, 3).toString();
					String s2 = table_1.getModel().getValueAt(row, 5).toString();
					id = table_1.getModel().getValueAt(row, 0).toString();
					product = table_1.getModel().getValueAt(row, 1).toString();
					textField.setText(s1);
					textField_1.setText(s2);
				}
			});
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this, "No se pudo armar la tabla.");
		}
		JScrollPane scrollPane = new JScrollPane(table_1);
		scrollPane.setBounds(208, 70, 576, 392);
		getContentPane().add(scrollPane);
		
		JButton btnNewButton = new JButton("Actualizar");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				MyConnection my = new MyConnection();
				ResultSet rs = my.execute("call actualizarMercado ('"+ textField_2.getText() +"','" + product +  "', "+ textField.getText() +"," + textField_1.getText() +" , "+ id +")");
				try {
					rs.next();
					JOptionPane.showMessageDialog(null,	rs.getString(1));
					ResultSet r2 = my.execute(sql);
					table_1.setModel(TestConnection.buildTableModel(r2));
				} catch (HeadlessException | SQLException e) {
					JOptionPane.showMessageDialog(null,e);
				}
			}
		});
		btnNewButton.setForeground(Color.WHITE);
		btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 20));
		btnNewButton.setBackground(Color.DARK_GRAY);
		btnNewButton.setBounds(15, 415, 183, 36);
		getContentPane().add(btnNewButton);
		
		textField = new JTextField();
		textField.setBounds(15, 107, 86, 20);
		getContentPane().add(textField);
		textField.setColumns(10);
		
		JLabel lblNewLabel_1 = new JLabel("Cantidad Agregada");
		lblNewLabel_1.setForeground(Color.WHITE);
		lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 20));
		lblNewLabel_1.setBounds(15, 80, 183, 27);
		getContentPane().add(lblNewLabel_1);
		
		JLabel lblCantidadFinal = new JLabel("Cantidad Final");
		lblCantidadFinal.setForeground(Color.WHITE);
		lblCantidadFinal.setFont(new Font("Tahoma", Font.PLAIN, 20));
		lblCantidadFinal.setBounds(15, 135, 153, 27);
		getContentPane().add(lblCantidadFinal);
		
		textField_1 = new JTextField();
		textField_1.setColumns(10);
		textField_1.setBounds(15, 162, 86, 20);
		getContentPane().add(textField_1);
		
		JLabel lblNombreDeBodega = new JLabel("Nombre de Bodega");
		lblNombreDeBodega.setForeground(Color.WHITE);
		lblNombreDeBodega.setFont(new Font("Tahoma", Font.PLAIN, 20));
		lblNombreDeBodega.setBounds(15, 195, 192, 27);
		getContentPane().add(lblNombreDeBodega);
		
		textField_2 = new JTextField();
		textField_2.setColumns(10);
		textField_2.setBounds(15, 222, 86, 20);
		getContentPane().add(textField_2);
		
		
		setTitle("Editar Mercado");
		setBounds(50,50,800,500);
		
	}
}
