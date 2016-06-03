package view;

import javax.swing.JFrame;

import java.awt.Color;

import javax.swing.JPanel;
import javax.swing.JLabel;

import java.awt.Font;

import javax.swing.JOptionPane;
import javax.swing.SwingConstants;
import javax.swing.JTextField;
import javax.swing.JButton;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Toolkit;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JPasswordField;

import model.MyConnection;

public class EmpleadoSesion extends JFrame {
	private JTextField textField;
	private JFrame frame;
	private JPasswordField passwordField;
	private static String pass;
	
	
	public EmpleadoSesion() {
		setTitle("Empleado");
		setIconImage(Toolkit.getDefaultToolkit().getImage(EmpleadoSesion.class.getResource("/javax/swing/plaf/metal/icons/ocean/floppy.gif")));
		frame=this;
		
		setBounds(800,200,422,302);
		getContentPane().setBackground(new Color(47, 79, 79));
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(148, 0, 211));
		panel.setBounds(0, 0, 413, 66);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Bienvenido");
		lblNewLabel.setForeground(new Color(240, 255, 240));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setFont(new Font("Arial", Font.PLAIN, 28));
		lblNewLabel.setBounds(52, 11, 287, 44);
		panel.add(lblNewLabel);
		
		JLabel lblCedula = new JLabel("C\u00E9dula ");
		lblCedula.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblCedula.setHorizontalAlignment(SwingConstants.CENTER);
		lblCedula.setBounds(51, 99, 82, 25);
		getContentPane().add(lblCedula);
		
		textField = new JTextField();
		textField.setBounds(160, 101, 187, 20);
		getContentPane().add(textField);
		textField.setColumns(10);
		
		JLabel lblNewLabel_1 = new JLabel("Contrase\u00F1a");
		lblNewLabel_1.setFont(new Font("Arial", Font.PLAIN, 14));
		lblNewLabel_1.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_1.setBounds(51, 156, 82, 25);
		getContentPane().add(lblNewLabel_1);
		
		JButton btnNewButton = new JButton("Iniciar Sesi\u00F3n");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				
				if(passwordField.getPassword().length == 0){
					JOptionPane.showMessageDialog(null, "Ingresa una contraseña, no las has ingresado");
					return;
				}
				MyConnection my = new MyConnection();
				ResultSet result;
				String string;
				string=textField.getText();
				
				try{
					Integer.parseInt(string); 
				}
				catch(NumberFormatException  q){
					JOptionPane.showMessageDialog(null, " La cedula tiene que ser numeros  ");
					return ;
				}
				
				String s="call ConsultarEmpleado("+ textField.getText() +",'"+new String(passwordField.getPassword() )+"')";
				result=my.execute(s);
				
				pass=textField.getText();
				
				try {
					result.next();
					if(result.getString(1).equals("1")){
						//JOptionPane.showMessageDialog(null, "YESSSSSSS CORRECT");
						EmpleadoFrame sec=new EmpleadoFrame(false);
						sec.setVisible(true);	
						frame.dispose();
					}
					else
						JOptionPane.showMessageDialog(null, "Ha ingresado mal los datos");
						return;
				} catch (SQLException q) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null, " Ingresó mal la cedula   ");
				}
								
			}
		});
		
		btnNewButton.setBounds(160, 212, 163, 31);
		getContentPane().add(btnNewButton);
		
		passwordField = new JPasswordField();
		passwordField.setBounds(160, 156, 187, 20);
		getContentPane().add(passwordField);
			
	}
	
	public String getPass(){
		return pass;
	}

	public void setPass(String string) {
		pass = string;	
	}
}
