-- nomor 1
SELECT 
    * 
FROM 
    transaksi 
WHERE 
    tanggal_transaksi BETWEEN '2023-10-10' AND '2023-10-20';

-- nomor 2
SELECT t.id_transaksi, 
       SUM(m.harga_minuman * tm.jumlah_minuman) AS TOTAL_HARGA
FROM transaksi_minuman tm
JOIN menu_minuman m ON tm.tm_menu_minuman_id = m.id_minuman
JOIN transaksi t ON tm.tm_transaksi_id = t.id_transaksi
GROUP BY t.id_transaksi;

-- nomor 3
SELECT c.*, 
       COALESCE(SUM(harga_minuman * jumlah_minuman), 0) AS Total_Belanja
FROM customer c
LEFT JOIN membership m ON c.id_customer = m.m_id_customer
LEFT JOIN transaksi t ON c.id_customer = t.customer_id_customer
LEFT JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
LEFT JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
WHERE t.tanggal_transaksi BETWEEN '2023-10-03' AND '2023-10-22'
GROUP BY c.id_customer
ORDER BY c.nama_customer ASC;

-- nomor 4
SELECT p.*
FROM pegawai p
JOIN transaksi t ON p.nik = t.pegawai_nik
JOIN customer c ON t.customer_id_customer = c.id_customer
WHERE c.nama_customer IN ('Davi Liam', 'Sisil Triana', 'Hendra Asto');


-- nomor 5
SELECT 
    EXTRACT(MONTH FROM tanggal_transaksi) AS BULAN,
    EXTRACT(YEAR FROM tanggal_transaksi) AS TAHUN,
    COALESCE(SUM(jumlah_minuman), 0) AS JUMLAH_CUP
FROM transaksi t
JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
WHERE tanggal_transaksi BETWEEN '2023-10-01' AND '2023-10-31'
GROUP BY BULAN, TAHUN
ORDER BY TAHUN DESC, BULAN ASC;

-- nomor 6
SELECT AVG(total_belanja) AS rata_rata_total_belanja
FROM (
    SELECT c.id_customer,
           COALESCE(SUM(harga_minuman * jumlah_minuman), 0) AS total_belanja
    FROM customer c
    LEFT JOIN membership m ON c.id_customer = m.m_id_customer
    LEFT JOIN transaksi t ON c.id_customer = t.customer_id_customer
    LEFT JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
    LEFT JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
    GROUP BY c.id_customer
) AS transaksi_total_belanja;

-- nomor 7
SELECT c.id_customer, c.nama_customer, COALESCE(SUM(mm.harga_minuman * tm.jumlah_minuman), 0) AS total_belanja
FROM customer c
LEFT JOIN membership m ON c.id_customer = m.m_id_customer
LEFT JOIN transaksi t ON c.id_customer = t.customer_id_customer
LEFT JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
LEFT JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
GROUP BY c.id_customer
HAVING total_belanja > (SELECT AVG(total_belanja) FROM (
    SELECT c.id_customer, COALESCE(SUM(mm.harga_minuman * tm.jumlah_minuman), 0) AS total_belanja
    FROM customer c
    LEFT JOIN membership m ON c.id_customer = m.m_id_customer
    LEFT JOIN transaksi t ON c.id_customer = t.customer_id_customer
    LEFT JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
    LEFT JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
    GROUP BY c.id_customer
) AS transaksi_total_belanja)
ORDER BY total_belanja DESC;

-- nomor 8
SELECT *
FROM customer
WHERE id_customer NOT IN (SELECT m_id_customer FROM membership WHERE m_id_customer IS NOT NULL);

-- nomor 9
SELECT COUNT(DISTINCT t.customer_id_customer) AS jumlah_customer_latte
FROM transaksi t
JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
WHERE mm.nama_minuman = 'Latte';

-- nomor 10
SELECT c.nama_customer, mm.nama_minuman, SUM(tm.jumlah_minuman) AS total_jumlah_cup
FROM customer c
JOIN transaksi t ON c.id_customer = t.customer_id_customer
JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
WHERE c.nama_customer LIKE 'S%'
GROUP BY c.nama_customer, mm.nama_minuman;




