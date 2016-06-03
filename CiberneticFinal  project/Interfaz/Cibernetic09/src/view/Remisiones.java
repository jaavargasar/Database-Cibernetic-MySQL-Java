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
import javax.swing.JTextPane;

public class Remisiones extends JFrame {
	private JTable table_1;
	private String id;
	public Remisiones(ResultSet rs) {
		getContentPane().setBackground(new Color(0, 139, 139));
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(65, 105, 225));
		panel.setBounds(0, 0, 784, 71);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Remisiones");
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 29));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(0, 0, 784, 71);
		panel.add(lblNewLabel);
		
		try {
			table_1 = new JTable(TestConnection.buildTableModel(rs));
			table_1.addMouseListener(new MouseAdapter() {
				
				@Override
				public void mouseClicked(MouseEvent e) {
					int row = table_1.getSelectedRow();
					id = table_1.getModel().getValueAt(row, 0).toString();
				}
			});
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(this, "No se pudo armar la tabla.");
		}
		JScrollPane scrollPane = new JScrollPane(table_1);
		scrollPane.setBounds(0, 70, 576, 392);
		getContentPane().add(scrollPane);
		
		JButton btnConsultarRemisionSeleccionada = new JButton("Ver detalles");
		btnConsultarRemisionSeleccionada.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MyConnection my = new MyConnection();
				ResultSet rs = my.execute("call detalleRemision (" + id  +  ")" ) ;
				try {
					JTable table = new JTable(TestConnection.buildTableModel(rs));
					JOptionPane.showMessageDialog(null, new JScrollPane(table));
				} catch (HeadlessException | SQLException e1) {
					// TODO Auto-generated catch block
					JOptionPane.showMessageDialog(null,e1);
				}
			}
		});
		btnConsultarRemisionSeleccionada.setForeground(Color.WHITE);
		btnConsultarRemisionSeleccionada.setFont(new Font("Tahoma", Font.PLAIN, 17));
		btnConsultarRemisionSeleccionada.setBackground(Color.DARK_GRAY);
		btnConsultarRemisionSeleccionada.setBounds(582, 86, 187, 36);
		getContentPane().add(btnConsultarRemisionSeleccionada);
		
		JTextPane txtpnParaVerDetalles = new JTextPane();
		txtpnParaVerDetalles.setText("Para ver detalles, haga clic sobre una remision y acontinuacion en el boton ver detalles.");
		txtpnParaVerDetalles.setForeground(new Color(255, 255, 255));
		txtpnParaVerDetalles.setEditable(false);
		txtpnParaVerDetalles.setBackground(new Color(128, 128, 128));
		txtpnParaVerDetalles.setBounds(586, 133, 183, 55);
		getContentPane().add(txtpnParaVerDetalles);
		
		
		setTitle("Editar Mercado");
		setBounds(50,50,800,500);
		
	}
}
