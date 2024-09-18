create database QuanLyCCCD
use QuanLyCCCD
-- T?o b?ng NguoiDung ?? l?u thông tin công dân, nhân viên, và qu?n tr? viên
CREATE TABLE NguoiDung (
    MaNguoiDung INT PRIMARY KEY IDENTITY(1,1),
    LoaiNguoiDung NVARCHAR(50) NOT NULL, -- 'CongDan', 'NhanVien', 'QuanTriVien'
    TaiKhoan NVARCHAR(100) NOT NULL UNIQUE,
    MatKhau NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(15) NOT NULL
);

-- T?o b?ng CongDan ?? l?u thông tin cá nhân chi ti?t c?a công dân
CREATE TABLE CongDan (
    MaCongDan INT PRIMARY KEY IDENTITY(1,1),
    NguoiDungID INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    DiaChi NVARCHAR(200),
    SoCCCD NVARCHAR(12) UNIQUE
);

-- T?o b?ng NhanVienQuanLy ?? l?u thông tin nhân viên qu?n lý
CREATE TABLE NhanVienQuanLy (
    MaNhanVien INT PRIMARY KEY IDENTITY(1,1),
    MaNguoiDung INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    HoTen NVARCHAR(100),
    PhongBan NVARCHAR(100)
);

-- T?o b?ng CanCuocCongDan ?? l?u thông tin c?n c??c công dân
CREATE TABLE CanCuocCongDan (
    MaCanCuoc INT PRIMARY KEY IDENTITY(1,1),
    MaCongDan INT FOREIGN KEY REFERENCES CongDan(MaCongDan),
    NgayCap DATE,
    NgayHetHan DATE,
    TrangThai NVARCHAR(50) -- 'HoatDong', 'BiKhoa', 'DaXoa'
);

-- T?o b?ng YeuCauCapPhat ?? qu?n lý yêu c?u c?p phát c?n c??c
CREATE TABLE YeuCauCapPhat (
    MaYeuCau INT PRIMARY KEY IDENTITY(1,1),
    MaCongDan INT FOREIGN KEY REFERENCES CongDan(MaCongDan),
    NgayYeuCau DATE,
    TrangThai NVARCHAR(50) -- 'ChoDuyet', 'DaDuyet', 'DaHuy'
);

-- T?o b?ng LichSuCapNhat ?? l?u l?ch s? c?p nh?t thông tin c?n c??c
CREATE TABLE LichSuCapNhat (
    MaLichSu INT PRIMARY KEY IDENTITY(1,1),
    MaCanCuoc INT FOREIGN KEY REFERENCES CanCuocCongDan(MaCanCuoc),
    NgayCapNhat DATE,
    NoiDungCapNhat NVARCHAR(200)
);

-- T?o b?ng ThongTinKhoa ?? l?u thông tin c?n c??c b? khóa ho?c xóa
CREATE TABLE ThongTinKhoa (
    MaKhoa INT PRIMARY KEY IDENTITY(1,1),
    MaCanCuoc INT FOREIGN KEY REFERENCES CanCuocCongDan(MaCanCuoc),
    NgayKhoa DATE,
    LyDo NVARCHAR(200)
);

-- T?o b?ng LogXacThuc ?? ghi l?i l?ch s? xác th?c c?a ng??i dùng
CREATE TABLE XacThuc (
    MaXacThuc INT PRIMARY KEY IDENTITY(1,1),
    MaNguoiDung INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    NgayXacThuc DATE,
    KetQua NVARCHAR(50) -- 'ThanhCong', 'ThatBai'
);

-- T?o b?ng QuyenHan ?? l?u thông tin quy?n h?n
CREATE TABLE QuyenHan (
    MaQuyenHan INT PRIMARY KEY IDENTITY(1,1),
    TenQuyenHan NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(200)
);

-- T?o b?ng NguoiDung_QuyenHan ?? liên k?t ng??i dùng v?i quy?n h?n
CREATE TABLE NguoiDung_QuyenHan (
    MaNguoiDung INT FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
    MaQuyenHan INT FOREIGN KEY REFERENCES QuyenHan(MaQuyenHan),
    PRIMARY KEY (MaNguoiDung, MaQuyenHan)
);

-- Thêm d? li?u m?u cho b?ng NguoiDung (bao g?m công dân, nhân viên qu?n lý, và qu?n tr? viên)
INSERT INTO NguoiDung (LoaiNguoiDung, TaiKhoan, MatKhau, Email, SoDienThoai)
VALUES 
    ('CongDan', 'congdan123', 'password123', 'congdan@example.com', '0397482322'),
    ('NhanVien', 'nhanvien123', 'password123', 'nhanvien@example.com', '0987654321'),
    ('QuanTriVien', 'admin123', 'password123', 'admin@example.com', '0923274982');

-- Thêm d? li?u m?u cho b?ng CongDan
INSERT INTO CongDan (NguoiDungID, HoTen, NgaySinh, DiaChi, SoCCCD)
VALUES 
    (1, N'Nguyen Van A', '2000-05-03', N'Hà N?i', '0849723843');

-- Thêm d? li?u m?u cho b?ng NhanVienQuanLy
INSERT INTO NhanVienQuanLy (MaNguoiDung, HoTen, PhongBan)
VALUES 
    (2, N'Tran Thi B', N'Phòng Qu?n lý Công dân');

-- Thêm quy?n h?n cho b?ng QuyenHan
INSERT INTO QuyenHan (TenQuyenHan, MoTa)
VALUES 
    ('QuanLyHeThong', 'Qu?n lý toàn b? h? th?ng'), 
    ('QuanLyNguoiDung', 'Qu?n lý thông tin ng??i dùng'),
    ('CapNhatThongTin', 'C?p nh?t thông tin c?n c??c'),
    ('XoaThongTin', 'Xóa ho?c khóa thông tin c?n c??c');

-- Liên k?t qu?n tr? viên v?i các quy?n h?n trong b?ng NguoiDung_QuyenHan
DECLARE @AdminID INT;
SET @AdminID = (SELECT MaNguoiDung FROM NguoiDung WHERE TaiKhoan = 'admin123');

INSERT INTO NguoiDung_QuyenHan (MaNguoiDung, MaQuyenHan)
SELECT @AdminID, MaQuyenHan FROM QuyenHan;