package view;

import javax.swing.JFrame;

import java.awt.Color;
import java.awt.HeadlessException;

import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.SwingConstants;

import java.awt.Font;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Logger;

import javax.swing.JTextField;
import javax.swing.JFormattedTextField;
import javax.swing.text.MaskFormatter;
import javax.swing.JButton;

import Test.TestConnection;
import model.MyConnection;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class GerenteFrame extends JFrame {
	private JTextField textField;
	private JTextField textField_1;
	
	public GerenteFrame() {
		setBounds(50,50,800,500);
		getContentPane().setBackground(new Color(0, 139, 139));
		getContentPane().setLayout(null);

		JPanel panel = new JPanel();
		panel.setBackground(new Color(34, 139, 34));
		panel.setBounds(0, 0, 784, 67);
		getContentPane().add(panel);
		panel.setLayout(null);

		JLabel lblNewLabel = new JLabel("\u00A1Bienvenido!");
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Microsoft PhagsPa", Font.BOLD, 36));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(10, 5, 764, 51);
		panel.add(lblNewLabel);

		JPanel panel_1 = new JPanel();
		panel_1.setBackground(new Color(70, 130, 180));
		panel_1.setBounds(0, 67, 400, 395);
		getContentPane().add(panel_1);
		panel_1.setLayout(null);

		JPanel panel_2 = new JPanel();
		panel_2.setBackground(new Color(105, 105, 105));
		panel_2.setBounds(0, 0, 400, 78);
		panel_1.add(panel_2);
		panel_2.setLayout(null);

		JLabel lblNewLabel_1 = new JLabel("Mercados");
		lblNewLabel_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1.setFont(new Font("Microsoft PhagsPa", Font.BOLD, 32));
		lblNewLabel_1.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_1.setBounds(0, 0, 400, 78);
		panel_2.add(lblNewLabel_1);

		JLabel lblNewLabel_2 = new JLabel("Consultar Mercado");
		lblNewLabel_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_2.setFont(new Font("Tahoma", Font.PLAIN, 18));
		lblNewLabel_2.setBounds(10, 89, 220, 36);
		panel_1.add(lblNewLabel_2);

		JLabel lblNewLabel_3 = new JLabel("Fecha:");
		lblNewLabel_3.setBounds(10, 124, 75, 14);
		panel_1.add(lblNewLabel_3);

		final JFormattedTextField frmtdtxtfldDdmmaaaa = new JFormattedTextField();
		frmtdtxtfldDdmmaaaa.setText("AAAA/DD/MM");
		try {
			MaskFormatter dateMask = new MaskFormatter("####/##/##");
			dateMask.install(frmtdtxtfldDdmmaaaa);
		} catch (Exception ex) {
			JOptionPane.showMessageDialog(null, ex);
			//Logger.getLogger(MaskFormatterTest.class.getName()).log(Level.SEVERE, null, ex);
		}
		frmtdtxtfldDdmmaaaa.setBounds(71, 121, 91, 20);
		panel_1.add(frmtdtxtfldDdmmaaaa);
		
		JButton btnNewButton = new JButton("Consultar");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				try {
					ResultSet rs = my.execute("call mercadoFecha('" + frmtdtxtfldDdmmaaaa.getText()   + "')");
					JTable table = new JTable(TestConnection.buildTableModel(rs));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		});
		btnNewButton.setForeground(new Color(255, 255, 255));
		btnNewButton.setFont(new Font("Microsoft YaHei", Font.PLAIN, 17));
		btnNewButton.setBackground(new Color(128, 128, 128));
		btnNewButton.setBounds(219, 89, 160, 26);
		panel_1.add(btnNewButton);
		
		JLabel lblInsertarMercado = new JLabel("Insertar Mercado");
		lblInsertarMercado.setForeground(Color.WHITE);
		lblInsertarMercado.setFont(new Font("Tahoma", Font.PLAIN, 18));
		lblInsertarMercado.setBounds(10, 169, 181, 36);
		panel_1.add(lblInsertarMercado);
		
		JLabel label_1 = new JLabel("Fecha:");
		label_1.setBounds(10, 204, 75, 14);
		panel_1.add(label_1);
		
		final JFormattedTextField formattedTextField = new JFormattedTextField();
		formattedTextField.setText("AAAA/DD/MM");
		formattedTextField.setText("AAAA/DD/MM");
		try {
			MaskFormatter dateMask = new MaskFormatter("####/##/##");
			dateMask.install(formattedTextField);
		} catch (Exception ex) {
			JOptionPane.showMessageDialog(null, ex);
			//Logger.getLogger(MaskFormatterTest.class.getName()).log(Level.SEVERE, null, ex);
		}
		formattedTextField.setBounds(71, 201, 91, 20);
		panel_1.add(formattedTextField);
		
		JButton btnAgregar = new JButton("Agregar!");
		btnAgregar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs = my.execute("call insertarMercado ('" + formattedTextField.getText()  +  "')" ) ;
				try {
					JTable table = new JTable(TestConnection.buildTableModel(rs));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				} catch (HeadlessException | SQLException e1) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null,e1);
				}
			}
		});
		btnAgregar.setForeground(Color.WHITE);
		btnAgregar.setFont(new Font("Microsoft YaHei", Font.PLAIN, 17));
		btnAgregar.setBackground(Color.GRAY);
		btnAgregar.setBounds(240, 189, 139, 39);
		panel_1.add(btnAgregar);
		
		JButton btnConsultas = new JButton("Consultas");
		btnConsultas.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				ConsultasGerente cg = new ConsultasGerente();
				cg.setVisible(true);
			}
		});
		btnConsultas.setForeground(Color.WHITE);
		btnConsultas.setFont(new Font("Microsoft YaHei", Font.PLAIN, 17));
		btnConsultas.setBackground(Color.GRAY);
		btnConsultas.setBounds(60, 266, 280, 72);
		panel_1.add(btnConsultas);
		
		JButton btnEditar = new JButton("Editar \u00DAltimo");
		btnEditar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				String sql  = "call getLastMercado()";
				ResultSet rs = my.execute(sql);
				ResultSet rs1 = my.execute("call getLastDate()");
				try {
					rs1.next();
					String fecha = rs1.getString(1);
					MarketFrame mf = new MarketFrame(rs,sql,fecha);
					mf.setVisible(true);
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
			}
		});
		btnEditar.setForeground(Color.WHITE);
		btnEditar.setFont(new Font("Microsoft YaHei", Font.PLAIN, 17));
		btnEditar.setBackground(Color.GRAY);
		btnEditar.setBounds(219, 124, 160, 26);
		panel_1.add(btnEditar);
		
		JButton btnNewButton_1 = new JButton("Pasar a interfaz de empleado");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				EmpleadoFrame cf = new EmpleadoFrame(true);
				cf.setVisible(true);
			}
		});
		btnNewButton_1.setFont(new Font("Microsoft PhagsPa", Font.PLAIN, 22));
		btnNewButton_1.setForeground(new Color(255, 255, 255));
		btnNewButton_1.setBackground(new Color(105, 105, 105));
		btnNewButton_1.setBounds(430, 88, 329, 54);
		getContentPane().add(btnNewButton_1);
		
		JLabel lblCambiarPrecios = new JLabel("Cambiar Precios");
		lblCambiarPrecios.setForeground(Color.WHITE);
		lblCambiarPrecios.setFont(new Font("Tahoma", Font.PLAIN, 18));
		lblCambiarPrecios.setBounds(430, 153, 181, 36);
		getContentPane().add(lblCambiarPrecios);
		
		JButton btnCambiar = new JButton("Cambiar!");
		btnCambiar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs = my.execute("call changePriceProduct(" + textField_1.getText() + ",'" + textField.getText() + "')" );
				try {
					rs.next();
					JOptionPane.showMessageDialog(null, rs.getString(1));
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null,e1);
				}
				
			}
		});
		btnCambiar.setForeground(Color.WHITE);
		btnCambiar.setFont(new Font("Microsoft YaHei", Font.PLAIN, 17));
		btnCambiar.setBackground(Color.GRAY);
		btnCambiar.setBounds(620, 193, 139, 39);
		getContentPane().add(btnCambiar);
		
		textField = new JTextField();
		textField.setBounds(509, 194, 86, 20);
		getContentPane().add(textField);
		textField.setColumns(10);
		
		textField_1 = new JTextField();
		textField_1.setBounds(509, 225, 86, 20);
		getContentPane().add(textField_1);
		textField_1.setColumns(10);
		
		JLabel lblReferencia = new JLabel("Referencia:");
		lblReferencia.setBounds(432, 191, 83, 26);
		getContentPane().add(lblReferencia);
		
		JLabel lblNuevoPrecio = new JLabel("Nuevo Precio");
		lblNuevoPrecio.setBounds(430, 225, 83, 26);
		getContentPane().add(lblNuevoPrecio);
		
		JButton btnConsultarRemisiones = new JButton("Consultar Remisiones");
		btnConsultarRemisiones.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs = my.execute("call consultarRemisiones()");
				Remisiones r = new Remisiones(rs);
				r.setVisible(true);
			}
		});
		btnConsultarRemisiones.setForeground(Color.WHITE);
		btnConsultarRemisiones.setFont(new Font("Microsoft YaHei", Font.PLAIN, 17));
		btnConsultarRemisiones.setBackground(Color.GRAY);
		btnConsultarRemisiones.setBounds(430, 277, 329, 47);
		getContentPane().add(btnConsultarRemisiones);
		
		JButton btnVentasTotales = new JButton("Ventas totales");
		btnVentasTotales.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs = my.execute("call ventas()");
				try {
					rs.next();
					JOptionPane.showMessageDialog(null, "Ventas totales: $"+rs.getString(1));
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
			}
		});
		btnVentasTotales.setForeground(Color.WHITE);
		btnVentasTotales.setFont(new Font("Microsoft YaHei", Font.PLAIN, 17));
		btnVentasTotales.setBackground(Color.GRAY);
		btnVentasTotales.setBounds(430, 354, 329, 36);
		getContentPane().add(btnVentasTotales);
		setTitle("Gerente");
	}
}
