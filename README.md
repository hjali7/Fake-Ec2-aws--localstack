# 🖥️ Fake EC2 on AWS (with LocalStack + Docker + Nginx)

این پروژه یک شبیه‌ساز ساده برای EC2 در AWS هست که با استفاده از Docker و LocalStack پیاده‌سازی شده.
هدف اینه که بدون نیاز به اتصال واقعی به AWS، بتونی رفتار یک EC2 واقعی رو با سرویس‌های AWS مثل S3 تجربه کنی.

---

## 📦 چه چیزی پیاده‌سازی شده؟

✅ راه‌اندازی یک کانتینر که نقش EC2 رو بازی می‌کنه  
✅ نصب Nginx داخل این EC2 فیک  
✅ اتصال این کانتینر به LocalStack به عنوان AWS لوکال  
✅ دانلود فایل HTML از سرویس S3 لوکال و نمایش اون در مرورگر  
✅ اجرای اسکریپت `init.sh` در لحظه بوت کانتینر (مثل user-data در EC2 واقعی)  
✅ اضافه کردن Basic Auth روی Nginx برای حفاظت از دسترسی  
✅ بررسی و مانیتورینگ سلامت (healthcheck) برای سرویس Nginx

---

## 🧱 ساختار پروژه

```
fake-ec2-nginx/
│
├── html/                   ← محتوای اولیه برای S3
│   └── index.html
│
├── init.sh                 ← اسکریپت راه‌انداز EC2 (دانلود فایل از S3 و اجرای nginx)
├── Dockerfile              ← ایمیج کاستوم بر پایه nginx:alpine
├── docker-compose.yml      ← اجرای EC2 و اتصال به LocalStack
├── nginx/
│   └── nginx.conf          ← کانفیگ کامل Nginx شامل auth و routing
├── .gitignore              ← جلوگیری از push فایل‌های حساس مثل .htpasswd
└── README.md               ← این فایل
```

---

## 🚀 اجرا

### 1. ساخت باکت در LocalStack و آپلود فایل

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://local-bucket
aws --endpoint-url=http://localhost:4566 s3 cp ./html/index.html s3://local-bucket/index.html
```

---

### 2. ساخت فایل احراز هویت

⚠️ فایل `.htpasswd` عمداً در `.gitignore` قرار گرفته. برای تست:

```bash
htpasswd -c .htpasswd hajali
```

پسورد را مثلاً `alihji` قرار بده.

---

### 3. اجرای پروژه

```bash
docker compose up -d --build
```

---

### 4. مشاهده نتیجه

در مرورگر برو به:

```
http://localhost:8080
```

🔐 باید پنجره لاگین بیاد.  
با یوزرنیم و پسورد وارد شو و محتوای HTML را ببین.

---

## 🔐 نکات امنیتی

- فایل `.htpasswd` در git قرار نمی‌گیرد (در `.gitignore`)
- Nginx با auth و deny دسترسی به فایل‌های حساس محافظت شده
- مسیر اصلی `/` نیاز به ورود دارد

---

## 🧠 ایده‌های توسعه بیشتر

- اضافه کردن CI/CD Script (فاز بعدی)
- اتصال به Lambda و DynamoDB
- ساخت صفحه مدیریت و داشبورد ساده
- اضافه کردن HTTPS با Let's Encrypt

---

## 🤝 مشارکت

اگر دوست داشتی این پروژه رو گسترش بدی، Pull Request بفرست.  
یا issue باز کن تا با هم ارتقاش بدیم 💪

---

## 📇 لایسنس

MIT License

---

> ساخته‌شده با ❤️ توسط [@hjali7](https://github.com/hjali7)