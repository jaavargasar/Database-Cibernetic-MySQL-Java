package view;

import javax.swing.JFrame;

import java.awt.Color;

import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JTable;

import java.awt.Font;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.SwingConstants;

import model.MyConnection;

import javax.swing.JButton;
import javax.swing.JTextField;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

import javax.swing.JSplitPane;
import javax.swing.JScrollPane;

import Test.TestConnection;

import java.awt.Toolkit;


public class EmpleadoFrame extends JFrame {
	private JTextField textField;
	private JTextField textField_1;
	private JTextField textField_2;
	private JTextField textField_3;
	private JTextField textField_4;
	private JTextField textField_5;
	private MyConnection my=new MyConnection();
	private ResultSet rst;
	private JTextField textField_6;
	private JTextField textField_7;
	private JTextField textField_8;
	private JTextField textField_9;
	private JTextField textField_10;
	private JTextField textField_11;
	
	
	public EmpleadoFrame(boolean isGerente) {
		setIconImage(Toolkit.getDefaultToolkit().getImage(EmpleadoFrame.class.getResource("/javax/swing/plaf/metal/icons/ocean/computer.gif")));
		setBounds(600,200,701,393);
		
		getContentPane().setBackground(new Color(100, 149, 237));
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(105, 105, 105));
		panel.setBounds(0, 0, 685, 71);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		EmpleadoSesion ini=new EmpleadoSesion();
		final MyConnection my = new MyConnection();
		ResultSet result;
		if(isGerente) ini.setPass("1");
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
		
		
		JLabel lblNewLabel = new JLabel("Bienvenido "+ans);
		lblNewLabel.setForeground(new Color(240, 255, 240));
		lblNewLabel.setBackground(new Color(240, 248, 255));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setFont(new Font("Arial", Font.PLAIN, 27));
		lblNewLabel.setBounds(173, 24, 384, 36);
		panel.add(lblNewLabel);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBackground(new Color(100, 149, 237));
		panel_1.setBounds(0, 71, 168, 289);
		getContentPane().add(panel_1);
		panel_1.setLayout(null);
		
		JButton btnConsultarInventario = new JButton("Consultar inventario");
		btnConsultarInventario.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				rst=my.execute("select idBodega from bodega where nombre= '"+textField.getText()+ "' limit 1");
				
				try {
					rst.next();
					rst=my.execute("call inventario("+rst.getInt(1)+")");
					TestConnection tst=new TestConnection();
					JTable table = new JTable(tst.buildTableModel(rst));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
					
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null, "A ocurrido un Error");
				}

			}
		});
		btnConsultarInventario.setBounds(10, 30, 148, 23);
		panel_1.add(btnConsultarInventario);
		
		textField = new JTextField();
		textField.setBounds(10, 89, 129, 20);
		panel_1.add(textField);
		textField.setColumns(10);
		
		JLabel lblBodega = new JLabel("Bodega");
		lblBodega.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblBodega.setHorizontalAlignment(SwingConstants.CENTER);
		lblBodega.setBounds(10, 64, 66, 23);
		panel_1.add(lblBodega);
		
		JPanel panel_2 = new JPanel();
		panel_2.setBackground(new Color(50, 205, 50));
		panel_2.setBounds(167, 71, 177, 289);
		getContentPane().add(panel_2);
		panel_2.setLayout(null);
		
		JButton btnAgregarProducto = new JButton("Agregar Producto");
		btnAgregarProducto.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				int a,b,c;
				
				rst=my.execute("select idProducti from product where pro_name= '"+textField_1.getText()+"' limit 1");
				
				try {
					rst.next();
					a=rst.getInt(1);
					rst=my.execute("select idBodega from bodega where nombre= '"+textField_2.getText()+ "' limit 1" );
					rst.next();
					b=rst.getInt(1);
					rst=my.execute("call actualiza("+a+","+b+","+textField_3.getText()+")");
					JOptionPane.showMessageDialog(null, "El Producto se Ha Agregado Satisfactoriamente ");
					
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null, "Hubo un error y no se pudo agregar el producto ");
				}
	
			}
		});
		btnAgregarProducto.setBounds(10, 29, 150, 26);
		panel_2.add(btnAgregarProducto);
		
		JLabel lblProducto = new JLabel("Producto");
		lblProducto.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblProducto.setHorizontalAlignment(SwingConstants.CENTER);
		lblProducto.setBounds(10, 66, 78, 17);
		panel_2.add(lblProducto);
		
		textField_1 = new JTextField();
		textField_1.setBounds(10, 90, 150, 17);
		panel_2.add(textField_1);
		textField_1.setColumns(10);
		
		JLabel lblBodega_1 = new JLabel("Bodega");
		lblBodega_1.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblBodega_1.setHorizontalAlignment(SwingConstants.CENTER);
		lblBodega_1.setBounds(10, 118, 78, 17);
		panel_2.add(lblBodega_1);
		
		textField_2 = new JTextField();
		textField_2.setBounds(10, 141, 150, 17);
		panel_2.add(textField_2);
		textField_2.setColumns(10);
		
		JLabel lblCantidad = new JLabel("Cantidad");
		lblCantidad.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblCantidad.setHorizontalAlignment(SwingConstants.CENTER);
		lblCantidad.setBounds(10, 169, 65, 17);
		panel_2.add(lblCantidad);
		
		textField_3 = new JTextField();
		textField_3.setBounds(10, 187, 150, 16);
		panel_2.add(textField_3);
		textField_3.setColumns(10);
		
		JPanel panel_3 = new JPanel();
		panel_3.setBackground(new Color(184, 134, 11));
		panel_3.setBounds(345, 71, 168, 289);
		getContentPane().add(panel_3);
		panel_3.setLayout(null);
		
		JButton btnNewButton = new JButton("Agregar Remisi\u00F3n");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				int id1=-1,id2=-1;
				
				rst=my.execute("select idBodega from bodega where nombre='"+textField_4.getText() +"' limit 1" );
				
				try {
					
					//Parte 1, ejecutar procedimiento call nuevaRemision(idBodega1,idBodega2);
					rst.next();
					id1=rst.getInt(1);
					rst=my.execute("select idBodega from bodega where nombre='"+textField_5.getText() +"' limit 1" );
					rst.next();
					id2=rst.getInt(1);
					
					my.execute("call nuevaRemision("+id1+","+id2+")");	
					
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null, "Hubo un error y no se pudo realizar la remision 1");
					return;
				}
				
				
				rst=my.execute("select idRemision from remision where Bodega_recibe= "+id2+
								" and Bodega_idBodega= "+id1+" and rem_fecha=current_date() limit 1");
				
				
				
				int idrem;
				try {
					rst.next();
					idrem=rst.getInt(1);
					rst=my.execute("select idProducti from product where pro_name='"+textField_6.getText()+"' limit 1");
					rst.next();
					my.execute("call insertarDetalleRemision("+idrem+","+textField_7.getText()+","+rst.getInt(1)+")");
					
					JOptionPane.showMessageDialog(null, "La remision se a agregado correctamente");
					
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, "Hubo un error y no se pudo realizar la remision 33");
					return;
				}

			}
		});
		btnNewButton.setBounds(10, 32, 148, 23);
		panel_3.add(btnNewButton);
		
		JLabel lblRemitente = new JLabel("Bodega Remitente");
		lblRemitente.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblRemitente.setHorizontalAlignment(SwingConstants.CENTER);
		lblRemitente.setBounds(10, 66, 129, 17);
		panel_3.add(lblRemitente);
		
		textField_4 = new JTextField();
		textField_4.setBounds(10, 89, 129, 17);
		panel_3.add(textField_4);
		textField_4.setColumns(10);
		
		JLabel lblReceptor = new JLabel("Bodega Receptor");
		lblReceptor.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblReceptor.setHorizontalAlignment(SwingConstants.CENTER);
		lblReceptor.setBounds(10, 117, 129, 17);
		panel_3.add(lblReceptor);
		
		textField_5 = new JTextField();
		textField_5.setBounds(10, 145, 129, 17);
		panel_3.add(textField_5);
		textField_5.setColumns(10);
		
		JLabel lblProducto_1 = new JLabel("Producto");
		lblProducto_1.setFont(new Font("Arial", Font.PLAIN, 14));
		lblProducto_1.setHorizontalAlignment(SwingConstants.CENTER);
		lblProducto_1.setBounds(10, 173, 76, 17);
		panel_3.add(lblProducto_1);
		
		textField_6 = new JTextField();
		textField_6.setBounds(10, 196, 129, 17);
		panel_3.add(textField_6);
		textField_6.setColumns(10);
		
		JLabel lblCantidad_1 = new JLabel("Cantidad");
		lblCantidad_1.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblCantidad_1.setHorizontalAlignment(SwingConstants.CENTER);
		lblCantidad_1.setBounds(20, 224, 66, 17);
		panel_3.add(lblCantidad_1);
		
		textField_7 = new JTextField();
		textField_7.setBounds(10, 247, 129, 17);
		panel_3.add(textField_7);
		textField_7.setColumns(10);
		
		JPanel panel_4 = new JPanel();
		panel_4.setBackground(new Color(95, 158, 160));
		panel_4.setBounds(514, 71, 171, 284);
		getContentPane().add(panel_4);
		panel_4.setLayout(null);
		
		JButton btnProducto = new JButton("Vender producto");
		btnProducto.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				
				int a;
				
				//Aqui
				MyConnection my1 = new MyConnection();
				ResultSet rs1,rs2,rs3;
				EmpleadoSesion sec=new EmpleadoSesion();
				rs1=my1.execute("call SelectIds('"+textField_8.getText() +"','"+textField_9.getText()+"')");
				rs2=my1.execute("select  per_id  from persona where per_cedula= "+ sec.getPass()  +" limit 1");
				rs3=my1.execute("select  per_id  from persona where per_cedula= "+ textField_11.getText() +" limit 1");
				
				try {
					rs1.next();
					rs2.next();
					rs3.next();
					rs3=my1.execute("call buyProduct("+textField_10.getText()+","+rs1.getInt(2)+","+rs3.getInt(1)+","+rs2.getInt(1)+","+ rs1.getInt(1)+")");
					rs3.next();
					JOptionPane.showMessageDialog(null, rs3.getString(1));
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				
			}
		});
		btnProducto.setFont(new Font("Tahoma", Font.PLAIN, 12));
		btnProducto.setBounds(10, 33, 148, 23);
		panel_4.add(btnProducto);
		
		JLabel lblProducto_2 = new JLabel("Producto");
		lblProducto_2.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblProducto_2.setHorizontalAlignment(SwingConstants.CENTER);
		lblProducto_2.setBounds(10, 60, 73, 23);
		panel_4.add(lblProducto_2);
		
		textField_8 = new JTextField();
		textField_8.setBounds(10, 84, 141, 20);
		panel_4.add(textField_8);
		textField_8.setColumns(10);
		
		JLabel lblBodega_2 = new JLabel("Bodega");
		lblBodega_2.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblBodega_2.setHorizontalAlignment(SwingConstants.CENTER);
		lblBodega_2.setBounds(10, 115, 73, 17);
		panel_4.add(lblBodega_2);
		
		textField_9 = new JTextField();
		textField_9.setBounds(10, 143, 141, 17);
		panel_4.add(textField_9);
		textField_9.setColumns(10);
		
		JLabel lblCantidad_2 = new JLabel("Cantidad");
		lblCantidad_2.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblCantidad_2.setHorizontalAlignment(SwingConstants.CENTER);
		lblCantidad_2.setBounds(10, 174, 73, 17);
		panel_4.add(lblCantidad_2);
		
		textField_10 = new JTextField();
		textField_10.setBounds(10, 193, 141, 17);
		panel_4.add(textField_10);
		textField_10.setColumns(10);
		
		JLabel lblCliente = new JLabel("CC. Cliente");
		lblCliente.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblCliente.setHorizontalAlignment(SwingConstants.CENTER);
		lblCliente.setBounds(10, 221, 73, 20);
		panel_4.add(lblCliente);
		
		textField_11 = new JTextField();
		textField_11.setBounds(10, 242, 141, 17);
		panel_4.add(textField_11);
		textField_11.setColumns(10);
		setBackground(new Color(240, 248, 255));
	}
}
