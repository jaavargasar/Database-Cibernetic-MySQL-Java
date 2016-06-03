package view;

import javax.swing.JFrame;

import java.awt.Color;
import java.awt.Toolkit;

import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import model.MyConnection;

import java.awt.Font;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JTextField;

import Test.TestConnection;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class ClienteFrame extends JFrame{
	private JTextField textField;
	private JTextField textField_1;
	private JTextField textField_2;
	private JTextField textField_4;
	public ClienteFrame(boolean isGerente, String cedula) {
		setBounds(400,200,625,368);
		setIconImage(Toolkit.getDefaultToolkit().getImage(ClienteFrame.class.getResource("/com/sun/java/swing/plaf/windows/icons/Computer.gif")));
		getContentPane().setBackground(new Color(51, 102, 153));
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(102, 102, 102));
		panel.setBounds(0, 0, 609, 59);
		getContentPane().add(panel);
		
		InicioCliente ini=new InicioCliente();
		MyConnection my = new MyConnection();
		ResultSet result;
		if(isGerente){
			ini.setPass("1");
		}
		String s="select per_name FROM  persona where per_cedula="+ini.getPass();
		result=my.execute(s);
		String ans="Usuario";
		
		
		try {
			result.next();
			ans=result.getString(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JLabel lblBienvenido = new JLabel("Bienvenido  "+ans);
		lblBienvenido.setFont(new Font("Tahoma", Font.PLAIN, 36));
		lblBienvenido.setForeground(Color.WHITE);
		panel.add(lblBienvenido);
		
		JButton btnNewButton = new JButton("Consultar Puntos\r\n");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {

				InicioCliente ini=new InicioCliente();
				MyConnection my = new MyConnection();
				ResultSet result1=my.execute("call puntosCedula("+ini.getPass()+")");
				
				try {
					result1.next();
					JOptionPane.showMessageDialog(null, "Sus Puntos son : "+ result1.getInt(1));
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				
				
				
			}
		});
		btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 15));
		btnNewButton.setBounds(31, 70, 175, 40);
		getContentPane().add(btnNewButton);
		
		JButton btnNewButton_1 = new JButton("Comprar");
		btnNewButton_1.setFont(new Font("Tahoma", Font.PLAIN, 15));
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
			//Aqui
			MyConnection my1 = new MyConnection();
			ResultSet rs1,rs2,rs3;
			InicioCliente ini=new InicioCliente();
			rs1=my1.execute("call SelectIds('"+textField.getText() +"','"+textField_1.getText()+"')");
			rs2=my1.execute("call getId("+ ini.getPass()  + ")");
			rs3=my1.execute("call getId("+  textField_4.getText() +")");
			int bodega_id=-2,producto_id=-2,cliente_id=-2,empleado_id=-2;
			try {
				rs1.next();
				rs2.next();
				rs3.next();
				bodega_id = rs1.getInt(2);
				cliente_id = rs2.getInt(1);
				empleado_id = rs3.getInt(1);
				producto_id = rs1.getInt(1);
				rs3=my1.execute("call buyProduct("+textField_2.getText()+","+bodega_id+","+cliente_id+","+empleado_id+","+producto_id+")");
				rs3.next();
				JOptionPane.showMessageDialog(null, rs3.getString(1));
				
			} catch (SQLException e) {
				StringBuilder sb = new StringBuilder();
				System.out.println(bodega_id+" "+cliente_id+" "+empleado_id+" "+producto_id);
				JOptionPane.showMessageDialog(null, "Error, verifique los datos");
				e.printStackTrace();
			}
					
			}
		});
		btnNewButton_1.setBounds(359, 70, 161, 40);
		getContentPane().add(btnNewButton_1);
		
		JLabel lblProducto = new JLabel("Producto");
		lblProducto.setFont(new Font("Tahoma", Font.PLAIN, 15));
		lblProducto.setBounds(280, 140, 63, 40);
		getContentPane().add(lblProducto);
		
		JLabel lblBodega = new JLabel("Bodega");
		lblBodega.setFont(new Font("Tahoma", Font.PLAIN, 15));
		lblBodega.setBounds(280, 181, 73, 20);
		getContentPane().add(lblBodega);
		
		JLabel lblCantidad = new JLabel("Cantidad");
		lblCantidad.setFont(new Font("Tahoma", Font.PLAIN, 15));
		lblCantidad.setBounds(280, 212, 63, 20);
		getContentPane().add(lblCantidad);
		
		JLabel lblEmpleado = new JLabel("Empleado CC.");
		lblEmpleado.setFont(new Font("Tahoma", Font.PLAIN, 15));
		lblEmpleado.setBounds(261, 255, 93, 25);
		getContentPane().add(lblEmpleado);
		
		textField = new JTextField();
		textField.setBounds(363, 152, 146, 20);
		getContentPane().add(textField);
		textField.setColumns(10);
		
		textField_1 = new JTextField();
		textField_1.setBounds(363, 183, 146, 18);
		getContentPane().add(textField_1);
		textField_1.setColumns(10);
		
		textField_2 = new JTextField();
		textField_2.setBounds(363, 214, 146, 18);
		getContentPane().add(textField_2);
		textField_2.setColumns(10);
		
		textField_4 = new JTextField();
		textField_4.setBounds(363, 259, 146, 21);
		getContentPane().add(textField_4);
		textField_4.setColumns(10);
		
		JButton btnNewButton_2 = new JButton("Consultar Compras");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				MyConnection my=new MyConnection();
				InicioCliente ini=new InicioCliente();
				ResultSet result1;
				result1=my.execute("select per_id from cliente join persona using(per_id) where per_cedula= "+ini.getPass()+" limit 1" );
				
				try {
					result1.next();
					result1=my.execute("call consultarCompras("+ result1.getInt(1) +")");
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				try {
				
					JTable table = new JTable(TestConnection.buildTableModel(result1));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				
				} catch (SQLException q) {
					// TODO Auto-generated catch block
					q.printStackTrace();
				}
				
				
				
				
			}
		});
		btnNewButton_2.setFont(new Font("Tahoma", Font.PLAIN, 17));
		btnNewButton_2.setBounds(31, 233, 175, 47);
		getContentPane().add(btnNewButton_2);
	}
	
	
	

}
