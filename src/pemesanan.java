
 import javax.swing.JOptionPane;
 import java.sql.Connection;
import javax.swing.table.DefaultTableModel;
 import javax.swing.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.swing.table.DefaultTableModel;

public class pemesanan extends javax.swing.JFrame {

    /**
     */
    public pemesanan() {
        initComponents();
        load_table();
        kosong();
    }
    
    private void kosong(){
     
       
    }
    public void load_table() {
    DefaultTableModel model = new DefaultTableModel();
    model.addColumn("NO");
    model.addColumn("KODE PEMESANAN");
    model.addColumn("JENIS PAKET");
    model.addColumn("JENIS PELAYANAN");
    model.addColumn("JENIS STATUS");
    model.addColumn("BERAT");
    model.addColumn("HARGA");
    model.addColumn("NAMA");
    model.addColumn("NOMOR TELEFON");
    model.addColumn("ALAMAT");
    model.addColumn("TIPE PEMESANAN");

    try {
        int no = 1;
        String sql = "SELECT pemesanan.kode_pemesanan, jpakaian.jenis_pakaian, jpelayanan.jenis_pelayanan, " +
                     "pemesanan.status, pemesanan.berat, pemesanan.harga, user.username, user.nohp, user.alamat, pemesanan.tipe " +
                     "FROM pemesanan " +
                     "JOIN user ON pemesanan.id_user = user.id_user " +
                     "JOIN jpakaian ON pemesanan.id_jpakaian = jpakaian.id_jpakaian " +
                     "JOIN jpelayanan ON pemesanan.id_jpelayanan = jpelayanan.id_jpelayanan " +
                     "ORDER BY pemesanan.kode_pemesanan DESC";

        java.sql.Connection conn = (Connection) koneksi.configDB();
        java.sql.Statement stm = conn.createStatement();
        java.sql.ResultSet res = stm.executeQuery(sql);

        // Corrected single while loop
        while (res.next()) {
            model.addRow(new Object[]{
                no++,
                res.getString(1), // KODE PEMESANAN
                res.getString(2), // JENIS PAKET
                res.getString(3), // JENIS PELAYANAN
                res.getString(4), // JENIS STATUS
                res.getString(5), // BERAT
                res.getString(6), // HARGA
                res.getString(7), // NAMA -> user.username
                res.getString(8), // NOMOR TELEFON -> user.nomor_telepon
                res.getString(9), // ALAMAT -> user.alamat
                res.getString(10) // TIPE PEMESANAN
            });
        }

        tbldata.setModel(model); // Set the model for the table after all data is loaded
    } catch (Exception e) {
        e.printStackTrace(); // Improved error handling
        JOptionPane.showMessageDialog(null, "Failed to load table data!");
    
    }
    
    
}
    private void showPaymentDialog(String harga, String noTransaksi, String kodePemesanan) {
    // Menampilkan input dialog untuk pembayaran
    String pembayaran = JOptionPane.showInputDialog(this, "Harga: " + harga + "\nMasukkan jumlah pembayaran:");

    if (pembayaran != null && !pembayaran.trim().isEmpty()) {
        try {
            // Konversi harga dan pembayaran ke integer
            int hargaInt = Integer.parseInt(harga);
            int pembayaranInt = Integer.parseInt(pembayaran);

            // Hitung kembalian
            int kembalian = pembayaranInt - hargaInt;

            // Tampilkan hasil pembayaran dan kembalian dalam dialog yang sama
            if (kembalian >= 0) {
                JOptionPane.showMessageDialog(this, 
                    "Pembayaran berhasil.\nKembalian Anda: " + kembalian, 
                    "Pembayaran Berhasil", 
                    JOptionPane.INFORMATION_MESSAGE);

                // Ambil tanggal dan waktu saat pembayaran
                LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String tanggalNota = now.format(formatter);

                // Simpan transaksi ke database
                saveTransaction(noTransaksi, tanggalNota, hargaInt, kodePemesanan, pembayaranInt, kembalian);

            } else {
                JOptionPane.showMessageDialog(this, 
                    "Pembayaran kurang. Mohon masukkan jumlah yang cukup.", 
                    "Error Pembayaran", 
                    JOptionPane.ERROR_MESSAGE);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Log stack trace
            JOptionPane.showMessageDialog(this, 
                "Input tidak valid. Masukkan angka yang benar.", 
                "Error Input", 
                JOptionPane.ERROR_MESSAGE);
        }
    } else {
        JOptionPane.showMessageDialog(this, 
            "Pembayaran dibatalkan.", 
            "Pembayaran Dibatalkan", 
            JOptionPane.INFORMATION_MESSAGE);
    }
}



private void saveTransaction(String noTransaksi, String tanggalNota, int totalHarga, String kodePemesanan, int bayar, int kembalian) {
    String sql = "INSERT INTO transaksi (no_transaksi, tanggal_nota, total_harga, kode_pemesanan, bayar, kembalian) VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection conn = koneksi.configDB();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        // Set parameters for the PreparedStatement
        pstmt.setString(1, noTransaksi);
        pstmt.setString(2, tanggalNota);
        pstmt.setInt(3, totalHarga);
        pstmt.setString(4, kodePemesanan);
        pstmt.setInt(5, bayar);
        pstmt.setInt(6, kembalian);

        // Execute the INSERT statement
        int rowsAffected = pstmt.executeUpdate();
        
        // Check if the transaction was successfully saved
        if (rowsAffected > 0) {
            JOptionPane.showMessageDialog(this, 
                "Transaksi berhasil disimpan.\n" +
                "No Transaksi: " + noTransaksi + "\n" +
                "Tanggal: " + tanggalNota + "\n" +
                "Total Harga: " + totalHarga + "\n" +
                "Kode Pemesanan: " + kodePemesanan + "\n" +
                "Bayar: " + bayar + "\n" +
                "Kembalian: " + kembalian, 
                "Transaksi Berhasil", 
                JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(this, 
                "Transaksi tidak dapat disimpan. Tidak ada perubahan pada database.", 
                "Error Database", 
                JOptionPane.ERROR_MESSAGE);
        }

    } catch (SQLException e) {
        // Display specific error message
        JOptionPane.showMessageDialog(this, 
            "Terjadi kesalahan saat menyimpan transaksi: " + e.getMessage(), 
            "Error Database", 
            JOptionPane.ERROR_MESSAGE);
        e.printStackTrace(); // Print stack trace for debugging
    }
}




    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jMenu1 = new javax.swing.JMenu();
        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tbldata = new javax.swing.JTable();
        jButton1 = new javax.swing.JButton();
        bayar = new javax.swing.JButton();
        kodepemesanan = new javax.swing.JTextField();
        jenispaket = new javax.swing.JTextField();
        jenispelayanan = new javax.swing.JTextField();
        status = new javax.swing.JTextField();
        berat = new javax.swing.JTextField();
        harga = new javax.swing.JTextField();
        username = new javax.swing.JTextField();
        nohp = new javax.swing.JTextField();
        alamat = new javax.swing.JTextField();
        tipepemesanan = new javax.swing.JTextField();
        jButton3 = new javax.swing.JButton();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu2 = new javax.swing.JMenu();
        jMenuItem1 = new javax.swing.JMenuItem();

        jMenu1.setText("jMenu1");

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));

        jLabel1.setFont(new java.awt.Font("Times New Roman", 1, 36)); // NOI18N
        jLabel1.setText("PEMESANAN");

        tbldata.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        tbldata.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tbldataMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(tbldata);

        jButton1.setBackground(new java.awt.Color(204, 255, 255));
        jButton1.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        jButton1.setText("TAMBAH PEMESANAN");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        bayar.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        bayar.setText("BAYAR PEMESANAN");
        bayar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                bayarActionPerformed(evt);
            }
        });

        harga.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                hargaActionPerformed(evt);
            }
        });

        username.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                usernameActionPerformed(evt);
            }
        });

        alamat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                alamatActionPerformed(evt);
            }
        });

        jButton3.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        jButton3.setText("EDIT PEMESANAN");
        jButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton3ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(17, 17, 17)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(407, 407, 407)
                        .addComponent(jLabel1)
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(alamat)
                                    .addComponent(tipepemesanan, javax.swing.GroupLayout.DEFAULT_SIZE, 150, Short.MAX_VALUE))
                                .addGap(18, 18, 18)
                                .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 203, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 203, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(bayar, javax.swing.GroupLayout.PREFERRED_SIZE, 203, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(nohp)
                                    .addComponent(username)
                                    .addComponent(harga)
                                    .addComponent(berat)
                                    .addComponent(kodepemesanan)
                                    .addComponent(jenispaket)
                                    .addComponent(jenispelayanan)
                                    .addComponent(status, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addGap(18, 18, 18)
                                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 697, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 166, Short.MAX_VALUE))))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(23, 23, 23)
                        .addComponent(kodepemesanan, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLabel1)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jenispaket, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jenispelayanan, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(status, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(berat, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(harga, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(username, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(nohp, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(alamat, javax.swing.GroupLayout.PREFERRED_SIZE, 38, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 76, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bayar, javax.swing.GroupLayout.PREFERRED_SIZE, 76, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 76, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(tipepemesanan, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(63, Short.MAX_VALUE))
        );

        jMenu2.setText("Menu");
        jMenu2.setFont(new java.awt.Font("Times New Roman", 1, 18)); // NOI18N

        jMenuItem1.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
        jMenuItem1.setText("Dashboard");
        jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem1ActionPerformed(evt);
            }
        });
        jMenu2.add(jMenuItem1);

        jMenuBar1.add(jMenu2);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        jPanel1.getAccessibleContext().setAccessibleName("rewdf");

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jMenuItem1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem1ActionPerformed
        // TODO add your handling code here:
        this.dispose();
        new dashboard().setVisible(true);
    }//GEN-LAST:event_jMenuItem1ActionPerformed

    private void bayarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_bayarActionPerformed
    int baris = tbldata.getSelectedRow();

if (baris != -1) { // Jika ada baris yang dipilih
    // Ambil data dari kolom yang sesuai
    String harga = tbldata.getValueAt(baris, 6).toString(); // Misal harga ada di kolom ke-6
    String noTransaksi = tbldata.getValueAt(baris, 1).toString(); // Misal noTransaksi ada di kolom ke-1
    String kodePemesanan = tbldata.getValueAt(baris, 2).toString(); // Misal kodePemesanan ada di kolom ke-2
    
    // Tampilkan dialog pembayaran
    showPaymentDialog(harga, noTransaksi, kodePemesanan);
} else {
    JOptionPane.showMessageDialog(this, "Pilih data pemesanan yang ingin dibayar!", "Peringatan", JOptionPane.WARNING_MESSAGE);
}




    }//GEN-LAST:event_bayarActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        this.dispose();
        new t_pemesanan().setVisible(true);
    }//GEN-LAST:event_jButton1ActionPerformed

    private void tbldataMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tbldataMouseClicked
  int baris = tbldata.rowAtPoint(evt.getPoint());
String namalengkap = tbldata.getValueAt(baris, 1).toString();
kodepemesanan.setText(namalengkap);
kodepemesanan.setEditable(false); // Make this field read-only

String jpaket = tbldata.getValueAt(baris, 2).toString();
jenispaket.setText(jpaket);

String jpelayanan = tbldata.getValueAt(baris, 3).toString();
jenispelayanan.setText(jpelayanan);

String statuspel = tbldata.getValueAt(baris, 4).toString();
status.setText(statuspel);

String beratpel = tbldata.getValueAt(baris, 5).toString();
berat.setText(beratpel);

String hargapel = tbldata.getValueAt(baris, 6).toString();
harga.setText(hargapel);

String usernamepel = tbldata.getValueAt(baris, 7).toString();
username.setText(usernamepel);
username.setEditable(false); // Make this field read-only

String notelp = tbldata.getValueAt(baris, 8).toString();
nohp.setText(notelp);
nohp.setEditable(false); // Make this field read-only

String alamatpel = tbldata.getValueAt(baris, 9).toString();
alamat.setText(alamatpel);
alamat.setEditable(false); // Make this field read-only

String tipe = tbldata.getValueAt(baris, 10).toString();
tipepemesanan.setText(tipe);
tipepemesanan.setEditable(false); // Make this field read-only

        
        
    }//GEN-LAST:event_tbldataMouseClicked

    private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton3ActionPerformed
 try {
    // Membuat koneksi
    java.sql.Connection conn = (java.sql.Connection) koneksi.configDB();
    
    // Query SQL untuk memperbarui tabel pemesanan menggunakan subquery
    String sql = "UPDATE pemesanan " +
                 "SET id_jpakaian = (SELECT id_jpakaian FROM jpakaian WHERE jenis_pakaian = ?), " +
                 "id_jpelayanan = (SELECT id_jpelayanan FROM jpelayanan WHERE jenis_pelayanan = ?), " +
                 "status = ?, berat = ?, harga = ? " +
                 "WHERE kode_pemesanan = ?";
    
    java.sql.PreparedStatement pst = conn.prepareStatement(sql);
    
    // Debugging
    System.out.println("Jenis Pakaian: " + jenispaket.getText());
    System.out.println("Jenis Pelayanan: " + jenispelayanan.getText());
    System.out.println("Status: " + status.getText());
    System.out.println("Berat: " + berat.getText());
    System.out.println("Harga: " + harga.getText());
    System.out.println("Kode Pemesanan: " + kodepemesanan.getText());
    
    // Set nilai untuk placeholder (?)
    pst.setString(1, jenispaket.getText());
    pst.setString(2, jenispelayanan.getText());
    pst.setString(3, status.getText());
    pst.setString(4, berat.getText());
    pst.setString(5, harga.getText());
    pst.setString(6, kodepemesanan.getText());
    
    // Eksekusi update
    int rowsUpdated = pst.executeUpdate();
    
    // Periksa apakah ada baris yang diperbarui
    if (rowsUpdated > 0) {
        JOptionPane.showMessageDialog(null, "Data Berhasil di Update!");
    } else {
        JOptionPane.showMessageDialog(null, "Tidak ada data yang diupdate. Pastikan kode_pemesanan benar.");
    }

} catch (Exception e) {
    e.printStackTrace();
    JOptionPane.showMessageDialog(null, "Perubahan Data Gagal\n" + e.getMessage());
}

// Kosongkan input fields dan muat ulang data tabel
kosong();
load_table();


    }//GEN-LAST:event_jButton3ActionPerformed

    private void hargaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_hargaActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_hargaActionPerformed

    private void alamatActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_alamatActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_alamatActionPerformed

    private void usernameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_usernameActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_usernameActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(pemesanan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(pemesanan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(pemesanan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(pemesanan.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new pemesanan().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField alamat;
    private javax.swing.JButton bayar;
    private javax.swing.JTextField berat;
    private javax.swing.JTextField harga;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton3;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenu jMenu2;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextField jenispaket;
    private javax.swing.JTextField jenispelayanan;
    private javax.swing.JTextField kodepemesanan;
    private javax.swing.JTextField nohp;
    private javax.swing.JTextField status;
    private javax.swing.JTable tbldata;
    private javax.swing.JTextField tipepemesanan;
    private javax.swing.JTextField username;
    // End of variables declaration//GEN-END:variables
}
