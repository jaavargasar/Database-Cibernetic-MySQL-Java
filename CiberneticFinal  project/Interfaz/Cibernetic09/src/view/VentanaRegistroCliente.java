package view;

import javax.swing.JFrame;


import java.awt.Color;

import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.SwingConstants;
import javax.swing.JTextField;
import javax.swing.JPasswordField;

import java.awt.Font;

import javax.swing.JButton;

import Test.TestConnection;
import model.MyConnection;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

public class VentanaRegistroCliente extends JFrame {
	private JTextField textField;
	private JFrame frame;
	private JTextField textField_1;
	private JTextField textField_2;
	private JTextField textField_3;
	private JPasswordField passwordField;
	private JPasswordField passwordField_1;
	public VentanaRegistroCliente() {
		frame = this;
		getContentPane().setBackground(new Color(0, 128, 128));
		getContentPane().setLayout(null);
		
		setBounds(200,200,450,300);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(50, 205, 50));
		panel.setBounds(10, 11, 414, 80);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Nuevo Cliente!");
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Microsoft Sans Serif", Font.PLAIN, 42));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(0, 0, 414, 80);
		panel.add(lblNewLabel);
		
		textField = new JTextField();
		textField.setBounds(111, 102, 86, 20);
		getContentPane().add(textField);
		textField.setColumns(10);
		
		JLabel lblNombre = new JLabel("Nombre");
		lblNombre.setBounds(10, 105, 46, 14);
		getContentPane().add(lblNombre);
		
		JLabel lblCdula = new JLabel("C\u00E9dula");
		lblCdula.setBounds(10, 136, 46, 14);
		getContentPane().add(lblCdula);
		
		textField_1 = new JTextField();
		textField_1.setColumns(10);
		textField_1.setBounds(111, 133, 86, 20);
		getContentPane().add(textField_1);
		
		JLabel lblDireccin = new JLabel("Direcci\u00F3n");
		lblDireccin.setBounds(10, 164, 46, 14);
		getContentPane().add(lblDireccin);
		
		textField_2 = new JTextField();
		textField_2.setColumns(10);
		textField_2.setBounds(111, 161, 86, 20);
		getContentPane().add(textField_2);
		
		JLabel lblTelfono = new JLabel("Tel\u00E9fono");
		lblTelfono.setBounds(10, 192, 46, 14);
		getContentPane().add(lblTelfono);
		
		textField_3 = new JTextField();
		textField_3.setColumns(10);
		textField_3.setBounds(111, 189, 86, 20);
		getContentPane().add(textField_3);
		
		JLabel lblContrasea = new JLabel("Contrase\u00F1a");
		lblContrasea.setBounds(10, 220, 71, 14);
		getContentPane().add(lblContrasea);
		
		passwordField = new JPasswordField();
		passwordField.setBounds(111, 217, 86, 20);
		getContentPane().add(passwordField);
		
		JLabel lblRepitaContrasea = new JLabel("Repita contrase\u00F1a");
		lblRepitaContrasea.setBounds(207, 102, 105, 20);
		getContentPane().add(lblRepitaContrasea);
		
		passwordField_1 = new JPasswordField();
		passwordField_1.setBounds(327, 102, 86, 20);
		getContentPane().add(passwordField_1);
		
		JButton btnNewButton = new JButton("Reg\u00EDstrame :)");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				if(passwordField.getPassword().length == 0){
					JOptionPane.showMessageDialog(null, "Ingresa una contraseña, no las has ingresado");
					return;
				}
				if(!(Arrays.equals(passwordField.getPassword(), passwordField_1.getPassword()))){
					JOptionPane.showMessageDialog(null, "Las contraseñas no coinciden");
					return ;
				}
				
				MyConnection my = new MyConnection();
				String s =  "call insertarPersona ( '" + textField.getText() +  "', " 
							+ textField_1.getText() + ", '" + textField_2.getText() 
							+ "'," + textField_3.getText() + ",'" + new String(passwordField.getPassword()) +"')" ;
				my.execute(s);
				
				s = "call insertClienteCedula(" + textField_1.getText() +")";
			
				my.execute(s);
				
				JOptionPane.showMessageDialog(null, "Cliente ingresado con éxito");
				frame.dispose();
			}
		});
		btnNewButton.setBounds(236, 142, 150, 58);
		getContentPane().add(btnNewButton);
		setTitle("Nuevo Cliente!");
	}
}
