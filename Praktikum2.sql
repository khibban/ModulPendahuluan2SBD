
-- nomor 1

CREATE DATABASE KEDAI_KOPI_NORI;

CREATE TABLE Customer (
    ID_customer CHAR(6),
    nama_customer VARCHAR(100),
    PRIMARY KEY (ID_customer)
);

CREATE TABLE Pegawai (
    NIK CHAR(16),
    Nama_pegawai VARCHAR(100),
    Jenis_kelamin CHAR(15),
    Email VARCHAR(50),
    Umur INTEGER,
    PRIMARY KEY (NIK)
);

CREATE TABLE Transaksi (
    ID_transaksi CHAR(10),
    tanggal_transaksi DATE,
    Metode_pembayaran VARCHAR(15),
    ID_customer CHAR(6),
    NIK CHAR(16),
    PRIMARY KEY (ID_transaksi),
    FOREIGN KEY (ID_customer) REFERENCES Customer (ID_customer) ON UPDATE CASCADE,
    FOREIGN KEY (NIK) REFERENCES Pegawai(NIK)
);

CREATE TABLE Menu_minuman (
    ID_minuman CHAR(6),
    Nama_minuman VARCHAR(50),
    Harga_minuman float(2),
    PRIMARY KEY (ID_minuman)
);

CREATE TABLE Telepon (
    NO_telp_pegawai VARCHAR(15),
    NIK CHAR(16),
    PRIMARY KEY (NO_telp_pegawai),
    FOREIGN KEY (NIK) REFERENCES  Pegawai(NIK)
);

CREATE TABLE Transaksi_Menu (
    ID_transaksi CHAR(10),
    ID_minuman CHAR(6),
    Jumlah_Minuman INTEGER,
    PRIMARY KEY (ID_transaksi, ID_minuman),
    FOREIGN KEY (ID_transaksi) REFERENCES Transaksi(ID_transaksi),
    FOREIGN KEY (ID_minuman) REFERENCES Menu_minuman(ID_minuman)
);


--nomor 2
CREATE TABLE membership (
  id_membership CHAR(6),
  no_telepon_customer VARCHAR(15),
  alamat_customer VARCHAR(100),
  tanggal_pembuatan_kartu_membership DATE,
  tanggal_kedaluwarsa_kartu_membership DATE NULL,
  total_poin INT,
  customer_id_customer CHAR(6)
);

ALTER TABLE membership
ADD CONSTRAINT pk_id_membership PRIMARY KEY (id_membership);

ALTER TABLE membership ADD CONSTRAINT fk_customer_id_customer FOREIGN KEY (customer_id_customer) REFERENCES Customer (ID_customer)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE membership
ALTER COLUMN tanggal_pembuatan_kartu_membership SET DEFAULT CURRENT_DATE;

ALTER TABLE membership
ADD CONSTRAINT ck_total_poin CHECK (total_poin >= 0);

ALTER TABLE membership
MODIFY COLUMN alamat_customer VARCHAR(150);


-- nomor 3
DROP TABLE Telepon;

ALTER TABLE Pegawai
ADD nomor_telepon VARCHAR(15);

ALTER TABLE Pegawai
ADD CONSTRAINT uq_nomor_telepon UNIQUE (nomor_telepon);

-- nomor 4
INSERT INTO Customer (ID_customer, nama_customer)
VALUES
('CTR001', 'Budi Santoso'),
('CTR002', 'Sisil Triana'),
('CTR003', 'Davi Liam'),
('CTRo04', 'Sutris Ten An'),
('CTR005', 'Hendra Asto');

INSERT INTO membership (id_membership, no_telepon_customer, alamat_customer, tanggal_pembuatan_kartu_membership, tanggal_kedaluwarsa_kartu_membership, Total_poin, customer_id_customer)
VALUES
('MBRO01', '08123456789', 'Jl. Imam Bonjol', '2023-10-24', '2023-11-30', 0, 'CTR001'),
('MBR002', '0812345678', 'Jl. Kelinci', '2023-10-24', '2023-11-30', 3, 'CTR002'),
('MBR003', '081234567890', 'Jl. Abah Ojak', '2023-10-25', '2023-12-01', 2, 'CTR003'),
('MBR004', '08987654321', 'Jl. Kenangan', '2023-10-26', '2023-12-02', 6, 'CTR005');


INSERT INTO Pegawai (NIK, Nama_pegawai, Jenis_kelamin, Email, Umur, nomor_telepon)
VALUES
('1234567890123456', 'Naufal Raf', 'Laki-Laki', 'nuafal@gmail.com', 19, '62123456789'),
('2345678901234561', 'Surinala', 'Perempuan', 'surinala@gmail.com', 24, '621234567890'),
('3456789012345612', 'Ben John', 'Laki-Laki', 'benjohn@gmail.com', 22, '6212345678');


INSERT INTO Transaksi (ID_Transaksi, NIK, ID_customer, tanggal_transaksi, Metode_pembayaran)
VALUES
('TRX0000001', '2345678901234561', 'CTR002', '2023-10-01', 'Kartu kredit'),
('TRX0000002', '2345678901234561', 'CTRo04', '2023-10-03', 'Transfer bank'),
('TRX0000003', '3456789012345612', 'CTR001', '2023-10-05', 'Tunai'),
('TRX0000004', '1234567890123456', 'CTR003', '2023-10-15', 'Kartu debit'),
('TRX0000005', '1234567890123456', 'CTRo04', '2023-10-15', 'E-wallet'),
('TRX0000006', '2345678901234561', 'CTR001', '2023-10-21', 'Tunai');


INSERT INTO Menu_minuman (ID_minuman, Nama_minuman, Harga_minuman)
VALUES
('MNM001', 'Expresso', 18000),
('MNM002', 'Cappuccino', 20000),
('MNM003', 'Latte', 21000),
('MNM004', 'Americano', 19000),
('MNM005', 'Mocha', 22000),
('MNM006', 'Macchiato', 23000),
('MNM007', 'Cold Brew', 21000),
('MNM008', 'Iced Coffee', 18000),
('MNM009', 'Affogato', 23000),
('MNM010', 'Coffee Frappe', 22000);

INSERT INTO Transaksi_Menu (ID_Transaksi, ID_minuman, Jumlah_Minuman)
VALUES
('TRX0000005', 'MNM006', 2),
('TRX0000001', 'MNM010', 1),
('TRX0000002', 'MNM005', 1),
('TRX0000005', 'MNM009', 1),
('TRX0000003', 'MNM001', 3),
('TRX0000006', 'MNM003', 2),
('TRX0000004', 'MNM004', 2),
('TRX0000004', 'MNM010', 1),
('TRX0000002', 'MNM003', 2),
('TRX0000001', 'MNM007', 1),
('TRX0000005', 'MNM001', 1),
('TRX0000003', 'MNM003', 2);

--nomor 5

INSERT INTO Transaksi (ID_transaksi, Tanggal_transaksi, Metode_pembayaran, ID_customer, NIK)
VALUES
('TRX0000007', '2023-10-03', 'Transfer bank', 'CTRo04', '2345678901234561');

INSERT INTO Transaksi_Menu (ID_transaksi, ID_minuman, Jumlah_Minuman)
VALUES
('TRX0000007', 'MNM003', 1);

-- nomor 6

INSERT INTO Pegawai (NIK, Nama_pegawai, Umur)
VALUES
('1111222233334444', 'Maimunah',25);

-- nomor 7

UPDATE Customer
SET ID_customer = 'CTR004'
WHERE ID_customer = 'CTRo04';

-- nomor 8

UPDATE Pegawai
SET 
Jenis_kelamin = 'P',
nomor_telepon = '621234567',
Email = 'maimunah@gmail.com'
WHERE NIK = '1111222233334444';


-- nomor 9

UPDATE membership
SET Total_poin = 0
WHERE tanggal_kedaluwarsa_kartu_membership < CURRENT_DATE;


-- nomor 10

DELETE FROM membership;


-- nomor 11

DELETE FROM Pegawai
WHERE Nama_pegawai = 'Maimunah';
