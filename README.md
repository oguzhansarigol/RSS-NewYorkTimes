# Web Tabanlı Haber Çekme ve Görüntüleme Uygulaması

## Proje Açıklaması

Bu proje, .NET Web Forms teknolojisi kullanılarak geliştirilmiş bir haber çekme ve görüntüleme sistemidir. Uygulama, RSS kaynaklarından haberleri çekerek veritabanına kaydeder, tekrar eden haberleri engeller, kullanıcıya görsel ve metinsel olarak sunar ve detay sayfasında haberin tüm bilgilerini gösterir.

## Özellikler

- RSS kaynaklarından (NYTimes) haberleri çekme
- Haberleri `News` sınıfı ile temsil etme
- `ArrayList` yapısıyla geçici veri saklama
- Access (.accdb) veritabanına kayıt
- Aynı haberin tekrar eklenmesini önleme
- Eksik görsel veriler için placeholder kullanımı
- `Home.aspx` sayfasında modern tasarımlı, görselli haber listeleme
- `NewsDetail.aspx` sayfasında haberin tam detaylarını gösterme
- NLog kütüphanesi ile hata durumlarında loglama
- Kategori ve tarih gibi kriterlere göre filtreleme alt yapısı

## Ekran Görüntüleri

### Ana Sayfa

![Ana Sayfa](Content/image1.png)

### Haber Detayı

![Haber Detayı](Content/image2.png)

## Kullanılan Teknolojiler

- ASP.NET Web Forms
- C#
- Microsoft Access (.accdb)
- XML / RSS
- NLog
- HTML + CSS (modern responsive tasarım)

## Dosya Yapısı

- `App_Data/News.accdb` → Access veritabanı
- `App_Code/News.cs` → Haber sınıfı
- `RSSparsing.aspx` → RSS'ten haberleri çeken ve veritabanına kaydeden sayfa
- `Home.aspx` → Ana sayfa, tüm haberlerin listelendiği yer
- `NewsDetail.aspx` → Tıklanan haberin detaylarının gösterildiği sayfa
- `Content/image1.png`, `Content/image2.png` → Ödev için ekran görüntüleri
- `NLog.config` → Loglama yapılandırma dosyası


## Gereksinimler

- Visual Studio 2022 veya üzeri
- .NET Framework 4.7.2+
- Access veritabanı desteği için ACE.OLEDB.12.0 sürücüsü

## Nasıl Çalıştırılır?

1. Projeyi Visual Studio'da aç
2. `RSSparsing.aspx` sayfasını sağ tıklayıp "Set as Start Page" yap
3. Uygulamayı çalıştır (F5)
4. Haberler veritabanına kaydedilir ve `Home.aspx` üzerinden görüntülenebilir
