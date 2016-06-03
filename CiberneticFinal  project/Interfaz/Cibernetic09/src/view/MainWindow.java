package view;

import java.awt.Dimension;
import java.awt.Toolkit;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;

import java.awt.Color;

import javax.swing.JLabel;
import javax.swing.SwingConstants;

import java.awt.Font;

import javax.swing.JButton;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Button;

import javax.swing.JCheckBox;
import java.awt.SystemColor;

public class MainWindow extends JFrame {
	public MainWindow() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		getContentPane().setBackground(new Color(0, 139, 139));
		
		setTitle("Cibernetic1.0");
		getContentPane().setLayout(null);
		setBounds(50, 50, 1200, 600);
		
		JMenuBar menuBar = new JMenuBar();
		menuBar.setBounds(0, 0, 1184, 31);
		getContentPane().add(menuBar);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(46, 139, 87));
		panel.setBounds(10, 42, 1164, 87);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		
		JLabel lblNewLabel = new JLabel("Bienvenido a Cibernetic");
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Magneto", Font.PLAIN, 44));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(0, 0, 1164, 87);
		panel.add(lblNewLabel);
		
		JCheckBox lblNewLabel_1 = new JCheckBox("");
		lblNewLabel_1.setBackground(new Color(0, 139, 139));
		lblNewLabel_1.setIcon(new ImageIcon("user.png"));
		lblNewLabel_1.setBounds(10, 211, 224, 271);
		getContentPane().add(lblNewLabel_1);
		
		JButton btnregstrate = new JButton("\u00A1Reg\u00EDstrate!");
		btnregstrate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				VentanaRegistroCliente vrc = new VentanaRegistroCliente();
				vrc.setVisible(true);
			}
		});
		btnregstrate.setBounds(244, 258, 175, 60);
		getContentPane().add(btnregstrate);
		
		JButton btnNewButton = new JButton("Inicia Sesi\u00F3n");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				InicioCliente ic = new InicioCliente();
				ic.setVisible(true);
			}
		});
		btnNewButton.setBounds(244, 333, 175, 60);
		getContentPane().add(btnNewButton);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBackground(new Color(50, 205, 50));
		panel_1.setBounds(10, 140, 224, 60);
		getContentPane().add(panel_1);
		panel_1.setLayout(null);
		
		JLabel lblNewLabel_2 = new JLabel("Clientes");
		lblNewLabel_2.setFont(new Font("Lucida Sans", Font.BOLD, 27));
		lblNewLabel_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_2.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_2.setBounds(0, 0, 224, 60);
		panel_1.add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("New label");
		lblNewLabel_3.setIcon(new ImageIcon("worker.png"));
		lblNewLabel_3.setBounds(470, 194, 224, 266);
		getContentPane().add(lblNewLabel_3);
		
		JPanel panel_2 = new JPanel();
		panel_2.setLayout(null);
		panel_2.setBackground(new Color(189, 183, 107));
		panel_2.setBounds(500, 140, 224, 60);
		getContentPane().add(panel_2);
		
		JLabel lblEmpleados = new JLabel("Empleados");
		lblEmpleados.setHorizontalAlignment(SwingConstants.CENTER);
		lblEmpleados.setForeground(Color.WHITE);
		lblEmpleados.setFont(new Font("Lucida Sans", Font.BOLD, 27));
		lblEmpleados.setBounds(0, 0, 224, 60);
		panel_2.add(lblEmpleados);
		
		JButton btnNewButton_1 = new JButton("Inicia Sesi\u00F3n");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				EmpleadoSesion sec=new EmpleadoSesion();
				sec.setVisible(true);	

			}
		});
		btnNewButton_1.setBounds(734, 258, 194, 60);
		getContentPane().add(btnNewButton_1);
		
		JButton btnAdministrador = new JButton("Administrador");
		btnAdministrador.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				GerenteSesion gf = new GerenteSesion();
				gf.setVisible(true);
			}
		});
		btnAdministrador.setBackground(new Color(105, 105, 105));
		btnAdministrador.setFont(new Font("Tahoma", Font.PLAIN, 20));
		btnAdministrador.setForeground(new Color(255, 255, 255));
		btnAdministrador.setBounds(950, 140, 224, 60);
		getContentPane().add(btnAdministrador);
		
		JButton btnConsultarEnvios = new JButton("Consultar Envios");
		btnConsultarEnvios.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				ProveedorSesion ps = new  ProveedorSesion();
				ps.setVisible(true);
				
			}
		});
		btnConsultarEnvios.setForeground(Color.WHITE);
		btnConsultarEnvios.setFont(new Font("Tahoma", Font.PLAIN, 20));
		btnConsultarEnvios.setBackground(SystemColor.controlDkShadow);
		btnConsultarEnvios.setBounds(950, 404, 224, 60);
		getContentPane().add(btnConsultarEnvios);
		
		JLabel lblProveedores = new JLabel("Proveedores");
		lblProveedores.setForeground(new Color(240, 255, 255));
		lblProveedores.setFont(new Font("Tahoma", Font.PLAIN, 32));
		lblProveedores.setHorizontalAlignment(SwingConstants.CENTER);
		lblProveedores.setBounds(950, 333, 224, 48);
		getContentPane().add(lblProveedores);
	}
	
	public static void main(String[] args) {
		MainWindow m = new MainWindow();
		m.setVisible(true);
	}
}
