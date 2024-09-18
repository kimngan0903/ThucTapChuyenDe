create database QuanLyCCCD
use QuanLyCCCD
-- T?o b?ng NguoiDung ?? l?u th�ng tin c�ng d�n, nh�n vi�n, v� qu?n tr? vi�n
CREATE TABLE NguoiDung (
    MaNguoiDung INT PRIMARY KEY IDENTITY(1,1),
    LoaiNguoiDung NVARCHAR(50) NOT NULL, -- 'CongDan', 'NhanVien', 'QuanTriVien'
    TaiKhoan NVARCHAR(100) NOT NULL UNIQUE,
    MatKhau NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(15) NOT NULL
);

-- T?o b?ng CongDan ?? l?u th�ng tin c� nh�n chi ti?t c?a c�ng d�n
CREATE TABLE CongDan (
    MaCongDan INT PRIMARY KEY IDENTITY(1,1),
    NguoiDungID INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    DiaChi NVARCHAR(200),
    SoCCCD NVARCHAR(12) UNIQUE
);

-- T?o b?ng NhanVienQuanLy ?? l?u th�ng tin nh�n vi�n qu?n l�
CREATE TABLE NhanVienQuanLy (
    MaNhanVien INT PRIMARY KEY IDENTITY(1,1),
    MaNguoiDung INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    HoTen NVARCHAR(100),
    PhongBan NVARCHAR(100)
);

-- T?o b?ng CanCuocCongDan ?? l?u th�ng tin c?n c??c c�ng d�n
CREATE TABLE CanCuocCongDan (
    MaCanCuoc INT PRIMARY KEY IDENTITY(1,1),
    MaCongDan INT FOREIGN KEY REFERENCES CongDan(MaCongDan),
    NgayCap DATE,
    NgayHetHan DATE,
    TrangThai NVARCHAR(50) -- 'HoatDong', 'BiKhoa', 'DaXoa'
);

-- T?o b?ng YeuCauCapPhat ?? qu?n l� y�u c?u c?p ph�t c?n c??c
CREATE TABLE YeuCauCapPhat (
    MaYeuCau INT PRIMARY KEY IDENTITY(1,1),
    MaCongDan INT FOREIGN KEY REFERENCES CongDan(MaCongDan),
    NgayYeuCau DATE,
    TrangThai NVARCHAR(50) -- 'ChoDuyet', 'DaDuyet', 'DaHuy'
);

-- T?o b?ng LichSuCapNhat ?? l?u l?ch s? c?p nh?t th�ng tin c?n c??c
CREATE TABLE LichSuCapNhat (
    MaLichSu INT PRIMARY KEY IDENTITY(1,1),
    MaCanCuoc INT FOREIGN KEY REFERENCES CanCuocCongDan(MaCanCuoc),
    NgayCapNhat DATE,
    NoiDungCapNhat NVARCHAR(200)
);

-- T?o b?ng ThongTinKhoa ?? l?u th�ng tin c?n c??c b? kh�a ho?c x�a
CREATE TABLE ThongTinKhoa (
    MaKhoa INT PRIMARY KEY IDENTITY(1,1),
    MaCanCuoc INT FOREIGN KEY REFERENCES CanCuocCongDan(MaCanCuoc),
    NgayKhoa DATE,
    LyDo NVARCHAR(200)
);

-- T?o b?ng LogXacThuc ?? ghi l?i l?ch s? x�c th?c c?a ng??i d�ng
CREATE TABLE XacThuc (
    MaXacThuc INT PRIMARY KEY IDENTITY(1,1),
    MaNguoiDung INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    NgayXacThuc DATE,
    KetQua NVARCHAR(50) -- 'ThanhCong', 'ThatBai'
);

-- T?o b?ng QuyenHan ?? l?u th�ng tin quy?n h?n
CREATE TABLE QuyenHan (
    MaQuyenHan INT PRIMARY KEY IDENTITY(1,1),
    TenQuyenHan NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(200)
);

-- T?o b?ng NguoiDung_QuyenHan ?? li�n k?t ng??i d�ng v?i quy?n h?n
CREATE TABLE NguoiDung_QuyenHan (
    MaNguoiDung INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    MaQuyenHan INT FOREIGN KEY REFERENCES QuyenHan(MaQuyenHan),
    PRIMARY KEY (MaNguoiDung, MaQuyenHan)
);

-- Th�m d? li?u m?u cho b?ng NguoiDung (bao g?m c�ng d�n, nh�n vi�n qu?n l�, v� qu?n tr? vi�n)
INSERT INTO NguoiDung (LoaiNguoiDung, TaiKhoan, MatKhau, Email, SoDienThoai)
VALUES 
    ('CongDan', 'congdan123', 'password123', 'congdan@example.com', '0397482322'),
    ('NhanVien', 'nhanvien123', 'password123', 'nhanvien@example.com', '0987654321'),
    ('QuanTriVien', 'admin123', 'password123', 'admin@example.com', '0923274982');

-- Th�m d? li?u m?u cho b?ng CongDan
INSERT INTO CongDan (NguoiDungID, HoTen, NgaySinh, DiaChi, SoCCCD)
VALUES 
    (1, N'Nguyen Van A', '2000-05-03', N'H� N?i', '0849723843');

-- Th�m d? li?u m?u cho b?ng NhanVienQuanLy
INSERT INTO NhanVienQuanLy (MaNguoiDung, HoTen, PhongBan)
VALUES 
    (2, N'Tran Thi B', N'Ph�ng Qu?n l� C�ng d�n');

-- Th�m quy?n h?n cho b?ng QuyenHan
INSERT INTO QuyenHan (TenQuyenHan, MoTa)
VALUES 
    ('QuanLyHeThong', 'Qu?n l� to�n b? h? th?ng'), 
    ('QuanLyNguoiDung', 'Qu?n l� th�ng tin ng??i d�ng'),
    ('CapNhatThongTin', 'C?p nh?t th�ng tin c?n c??c'),
    ('XoaThongTin', 'X�a ho?c kh�a th�ng tin c?n c??c');

-- Li�n k?t qu?n tr? vi�n v?i c�c quy?n h?n trong b?ng NguoiDung_QuyenHan
DECLARE @AdminID INT;
SET @AdminID = (SELECT MaNguoiDung FROM NguoiDung WHERE TaiKhoan = 'admin123');

INSERT INTO NguoiDung_QuyenHan (MaNguoiDung, MaQuyenHan)
SELECT @AdminID, MaQuyenHan FROM QuyenHan;