package view;

import javax.swing.JFrame;

import java.awt.Color;
import java.awt.HeadlessException;
import java.awt.Toolkit;

import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.SwingConstants;

import java.awt.Font;

import javax.swing.JTextField;
import javax.swing.JButton;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JPasswordField;

import model.MyConnection;

public class InicioCliente extends JFrame {
	private JTextField textField;
	private JPasswordField passwordField;
	private JFrame frame;
	private static String pass;
	
	public InicioCliente() {
		frame=this;
		setBounds(200,200,410,299);
		setTitle("Inicia Sesi\u00F3n");
		setIconImage(Toolkit.getDefaultToolkit().getImage(InicioCliente.class.getResource("/com/sun/java/swing/plaf/windows/icons/Computer.gif")));
		getContentPane().setBackground(new Color(0, 139, 139));
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(72, 61, 139));
		panel.setBounds(0, 0, 394, 88);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("\u00A1Bienvenido!");
		lblNewLabel.setFont(new Font("Microsoft JhengHei", Font.PLAIN, 33));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setBounds(69, 21, 235, 56);
		panel.add(lblNewLabel);
		
		JLabel lblCedula = new JLabel("C\u00E9dula");
		lblCedula.setFont(new Font("Arial", Font.PLAIN, 12));
		lblCedula.setBounds(31, 113, 72, 25);
		getContentPane().add(lblCedula);
		
		textField = new JTextField();
		textField.setBounds(113, 116, 188, 20);
		getContentPane().add(textField);
		textField.setColumns(10);
		
		JLabel lblContrasea = new JLabel("Contrase\u00F1a");
		lblContrasea.setFont(new Font("Arial", Font.PLAIN, 12));
		lblContrasea.setBounds(31, 159, 72, 25);
		getContentPane().add(lblContrasea);
		
		JButton btnNewButton = new JButton("Iniciar Sesi\u00F3n\r\n");
		btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 15));
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {

				if(passwordField.getPassword().length == 0){
					JOptionPane.showMessageDialog(null, "Ingresa una contraseņa, no las has ingresado");
					return;
				}			
				MyConnection my = new MyConnection();
				ResultSet result;
				String string;
				string=textField.getText();
				
				try{
					Integer.parseInt(string); 
				}
				catch(NumberFormatException  e){
					JOptionPane.showMessageDialog(null, " La cedula tiene que ser numeros  ");
					return ;
				}
				
				String s="call ConsultarClientes("+ textField.getText() +",'"+new String(passwordField.getPassword() )+"')";
				result=my.execute(s);
				
				pass=textField.getText();
				
				try {
					result.next();
					if(result.getString(1).equals("1")){
						//JOptionPane.showMessageDialog(null, "YESSSSSSS CORRECT");
						ClienteFrame vrc = new ClienteFrame(false,textField.getText());
						vrc.setVisible(true);	
						frame.dispose();
					}
					else
						JOptionPane.showMessageDialog(null, "Ha ingresado mal los datos");
						return;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null, " Ingreso mal la cedula   ");
				}		
			}
		});
		btnNewButton.setBounds(135, 196, 130, 37);
		getContentPane().add(btnNewButton);
		
		passwordField = new JPasswordField();
		passwordField.setToolTipText("");
		passwordField.setBounds(113, 162, 188, 20);
		getContentPane().add(passwordField);
		setBackground(new Color(0, 139, 139));
	}
	
	
	public String getPass(){
		return pass;
	}


	public void setPass(String s) {
		pass = s;
	}
	
}
