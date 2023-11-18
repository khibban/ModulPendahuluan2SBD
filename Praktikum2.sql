-- nomor 1

CREATE DATABASE Rental_Film_Beta;

CREATE TABLE kategori (
    k_id CHAR(6),
    k_jenis_kategori VARCHAR(50),
    PRIMARY KEY (k_id)
);

CREATE TABLE akses (
    ak_id CHAR(6),
    ak_jenis_akses VARCHAR(100),
    PRIMARY KEY(ak_id)
);

CREATE TABLE customer (
    cs_nik CHAR(16),
    cs_nama VARCHAR(100),
    cs_email VARCHAR(100),
    cs_alamat VARCHAR(100),
    cs_usia INTEGER,
    cs_jenis_kelamin CHAR(1),
    PRIMARY KEY (cs_nik)
);

CREATE TABLE film (
    f_id CHAR(6),
    f_judul VARCHAR(50),
    f_rumah_produksi VARCHAR(50),
    f_stok INTEGER,
    f_tahun_rilis INTEGER,
    f_durasi INTEGER,
    kategori_k_id CHAR(6),
    PRIMARY KEY (f_id),
    FOREIGN KEY (kategori_k_id) REFERENCES kategori(k_id)
);

CREATE TABLE pegawai (
    pe_nip CHAR(10),
    pe_nama VARCHAR(100),
    pe_no_telp VARCHAR(15),
    pe_email VARCHAR(100),
    pe_alamat VARCHAR(100),
    pe_jenis_kelamin CHAR(1),
    pe_usia INTEGER,
    akses_ak_id CHAR(6),
    PRIMARY KEY (pe_nip),
    FOREIGN KEY (akses_ak_id) REFERENCES akses(ak_id)
);

CREATE TABLE no_telp (
    no_nomor_telepon VARCHAR(15),
    customer_cs_nik CHAR(16),
    PRIMARY KEY (no_nomor_telepon),
    FOREIGN KEY (customer_cs_nik) REFERENCES customer(cs_nik)
);

CREATE TABLE transaksi_rental_film (
    trf_id CHAR(10),
    trf_tgl_rental DATE,
    trf_tgl_kembali DATE,
    trf_denda FLOAT(2),
    pegawai_pe_nip CHAR(10),
    customer_cs_nik CHAR(16),
    PRIMARY KEY (trf_id),
    FOREIGN KEY (pegawai_pe_nip) REFERENCES pegawai(pe_nip),
    FOREIGN KEY (customer_cs_nik) REFERENCES customer(cs_nik) 
);

CREATE TABLE rental_film (
    film_f_id CHAR(6),
    transaksi_rental_film_trf_id CHAR(10),
    PRIMARY KEY (film_f_id, transaksi_rental_film_trf_id),
    FOREIGN KEY (film_f_id) REFERENCES film(f_id),
    FOREIGN KEY (transaksi_rental_film_trf_id) REFERENCES transaksi_rental_film(trf_id)
);
-- nomor 2

CREATE TABLE sutradara (
    st_id CHAR(7),
    st_nama VARCHAR(40),
    st_reputasi FLOAT(2) NULL,
    PRIMARY KEY (st_id)
);

ALTER TABLE film 
ADD sutradara_st_id CHAR(7);

ALTER TABLE film 
ADD CONSTRAINT fk_st_id FOREIGN KEY (sutradara_st_id) REFERENCES sutradara(st_id)
ON UPDATE CASCADE 
ON DELETE CASCADE;

-- nomor 3

CREATE TABLE pekerjaan (
    pk_id INTEGER,
    pk_pekerjaan VARCHAR(25),
    PRIMARY KEY (pk_id)
);

ALTER TABLE pegawai
ADD pk_id INTEGER;

ALTER TABLE pegawai
ADD CONSTRAINT fk_pk_id FOREIGN KEY(pk_id) REFERENCES pekerjaan(pk_id)
ON DELETE CASCADE;



-- nomor 4

ALTER TABLE pegawai
ADD pe_jabatan VARCHAR(40);

ALTER TABLE pegawai
DROP CONSTRAINT fk_pk_id;

ALTER TABLE pegawai
DROP COLUMN pk_id;

DROP TABLE pekerjaan;

-- nomor 5

INSERT INTO kategori(k_id, k_jenis_kategori)
VALUES
('K00001', 'Romance'),
('K00002', 'Romcom'),
('K00003', 'Comedy'),
('K00004', 'Thriller'),
('K00005', 'Horror');

INSERT INTO akses(ak_id, ak_jenis_akses)
VALUES
('AK0001', 'staff'),
('AK0002', 'intern'),
('AK0003', 'admin');

INSERT INTO customer(cs_nik, cs_nama, cs_email, cs_alamat, cs_usia, cs_jenis_kelamin)
VALUES
('CUST000000000001','Glenn Tripet', 'gtripet0@patch.com' , '46603 Boyd', 18, 'F' ),
('CUST000000000002' , 'Faw Senescall', 'fsenescall1@spiegel.de', '132 Anderson Way', 54, 'F'),
('CUST000000000003' , 'Ab Gladstone', 'agladstone2@mayoclinic.com', '57 North Trail', 21, 'M'),
('CUST000000000004' , 'Peadar Dyson', 'pdyson3@newyorker.com', '8 Summerview Circle', 33, 'M');

INSERT INTO sutradara (st_id, st_nama, st_reputasi)
VALUES
('ST00001', 'Marga Eggerton', 96.06 ),
('ST00002', 'Demetria Genese', 84.66 ),
('ST00003', 'Cory Greenroa', 10.59 ),
('ST00004', 'Daveen Freestone', 42.32 );


INSERT INTO pegawai (pe_nip, pe_nama, pe_no_telp, pe_email, pe_alamat, pe_jenis_kelamin, pe_usia, pe_jabatan, akses_ak_id)
VALUES
('PE00000001','Jay Jordine','628173677924604','jjordine0@slideshare.net','6158 International Park','F', 39, 'intern', 'AK0002'),
('PE00000002','AngeMonkhouse','628934810980689','amonkhouse1@sohu.com','9 Macpherson Road','F', 30, 'staff', 'AK0001');

INSERT INTO no_telp(no_nomor_telepon, customer_cs_nik)
VALUES
('628729155673914', 'CUST000000000001'),
('628454187815572', 'CUST000000000002'),
('628803804248717', 'CUST000000000003'),
('628015403301463', 'CUST000000000004');

INSERT INTO transaksi_rental_film (trf_id, trf_tgl_rental, trf_tgl_kembali, trf_denda, pegawai_pe_nip, customer_cs_nik)
VALUES
('TRF0000001', '2023-03-02', '2023-03-13', NULL , 'PE00000001', 'CUST000000000001' ),
('TRF0000002', '2023-03-11', '2023-03-20', NULL , 'PE00000002', 'CUST000000000002' ),
('TRF0000003', '2023-04-01', '2023-04-28', 70000.00 , 'PE00000001', 'CUST000000000003' ),
('TRF0000004', '2023-04-29', '2023-05-05', 10000.00 , 'PE00000001', 'CUST000000000004' );

INSERT INTO film(f_id, f_judul, f_rumah_produksi, f_stok, f_tahun_rilis, f_durasi, kategori_k_id, sutradara_st_id)
VALUES
('F00001', 'Gangster', 'Aksa Bumi Langit', 191, 1994, 147, 'K00001', 'ST00001'),
('F00002', 'Gantian Dong', 'Aneka Cahaya Nusantara', 52, 2012, 169, 'K00002', 'ST00002'),
('F00003', 'Gara-gara', 'Butik Innovasi Maleo', 148, 2008, 159, 'K00003', 'ST00004'),
('F00004', 'Gara-gara Bola', 'Dapurfilm Production', 14, 1986, 114, 'K00004', 'ST00003'),
('F00005', 'Gara-gara Djanda Muda', 'Forka Sejahtera Nusantara', 156, 2002, 175, 'K00005', 'ST00002');

INSERT INTO rental_film (film_f_id, transaksi_rental_film_trf_id)
VALUES
('F00001', 'TRF0000001'),
('F00003', 'TRF0000001'),
('F00001', 'TRF0000002'),
('F00004', 'TRF0000003'),
('F00005', 'TRF0000004');


-- nomor 6
ALTER TABLE film
DROP CONSTRAINT film_ibfk_1;

ALTER TABLE kategori
MODIFY COLUMN k_id INTEGER AUTO_INCREMENT;
ALTER TABLE film
MODIFY COLUMN kategori_k_id INTEGER AUTO_INCREMENT;

ALTER TABLE film 
ADD CONSTRAINT fk_kategori_k_id FOREIGN KEY (kategori_k_id) REFERENCES kategori(k_id);

INSERT INTO kategori(k_jenis_kategori)
VALUES
('Documenter'),
('Science Fiction');

-- nomor 7
INSERT INTO pegawai (pe_nip, pe_nama, pe_no_telp, pe_email, pe_alamat, pe_jenis_kelamin, pe_usia, pe_jabatan, akses_ak_id)
VALUES
('PE00000003','Valeria Gala', '6281576821444', 'valgala@gmail.com', '“202 Getaway Street', 'F', 19, 'intern', 'AK0002')

UPDATE transaksi_rental_film
SET pegawai_pe_nip = 'PE00000003'
WHERE trf_id = 'TRF0000004'

-- nomor 8
UPDATE sutradara
SET st_reputasi = round(st_reputasi);

ALTER TABLE sutradara
MODIFY COLUMN st_reputasi INTEGER;

-- nomor 9

UPDATE transaksi_rental_film
SET trf_denda = NULL
WHERE customer_cs_nik = 'CUST000000000003';

UPDATE transaksi_rental_film
SET trf_denda = NULL
WHERE customer_cs_nik = 'CUST000000000004';

-- nomor 10
ALTER TABLE rental_film
DROP CONSTRAINT rental_film_ibfk_1;

ALTER TABLE rental_film 
ADD CONSTRAINT fk_rental_film_id FOREIGN KEY (film_f_id) REFERENCES film(f_id) ON DELETE CASCADE;

DELETE FROM film
WHERE f_tahun_rilis < 1990;

-- nomor 11

INSERT INTO transaksi_rental_film (trf_id, trf_tgl_rental, pegawai_pe_nip, customer_cs_nik)
VALUES
('TRF0000005', '2023-09-13', 'PE00000001', 'CUST000000000001' );

INSERT INTO rental_film (film_f_id, transaksi_rental_film_trf_id)
VALUES
('F00003', 'TRF0000005');

UPDATE film
SET f_stok = f_stok - 2
WHERE f_judul = 'Gara-gara';

UPDATE transaksi_rental_film
SET
trf_tgl_kembali =  '2023-12-20',
trf_denda = 40000
WHERE trf_id = 'TRF0000005';


UPDATE rental_film 
SET film_f_id = 'F00002'
WHERE transaksi_rental_film_trf_id = 'TRF0000005';

UPDATE film
SET f_stok = f_stok + 2
WHERE f_judul = 'Gara-gara';

UPDATE film
SET f_stok = f_stok - 2
WHERE f_judul = 'Gantian Dong';

-- nomor 12
ALTER TABLE no_telp 
DROP CONSTRAINT no_telp_ibfk_1;

ALTER TABLE transaksi_rental_film 
DROP CONSTRAINT transaksi_rental_film_ibfk_2;

ALTER TABLE transaksi_rental_film 
DROP CONSTRAINT transaksi_rental_film_ibfk_1;

ALTER TABLE rental_film 
DROP CONSTRAINT rental_film_ibfk_2;

ALTER TABLE rental_film
ADD CONSTRAINT rental_film_ibfk_2 FOREIGN KEY (transaksi_rental_film_trf_id) REFERENCES transaksi_rental_film(trf_id) ON DELETE CASCADE;


ALTER TABLE no_telp
ADD CONSTRAINT no_telp_ibfk_1 FOREIGN KEY (customer_cs_nik) REFERENCES customer(cs_nik) ON DELETE CASCADE;

ALTER TABLE transaksi_rental_film
ADD CONSTRAINT  transaksi_rental_film_ibfk_1 FOREIGN KEY (customer_cs_nik) REFERENCES customer(cs_nik) ON DELETE CASCADE;

ALTER TABLE transaksi_rental_film
ADD CONSTRAINT  transaksi_rental_film_ibfk_2 FOREIGN KEY (customer_cs_nik) REFERENCES customer(cs_nik) ON DELETE CASCADE;

DELETE FROM customer
WHERE cs_nik = 'CUST000000000001';