
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

---

## 🧱 ساختار پروژه

```
Fake-EC2-aws--localstack/
│
├── html/                   ← محتوای اولیه برای S3
│   └── index.html
│
├── init.sh                 ← اسکریپت راه‌انداز EC2 (دانلود فایل از S3 و اجرای nginx)
├── Dockerfile              ← ایمیج کاستوم بر پایه nginx:alpine
└── docker-compose.yml      ← اجرای EC2 و اتصال به LocalStack
```

---

## 🚀 اجرا

### 1. ساخت باکت در LocalStack و آپلود فایل

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-bucket
aws --endpoint-url=http://localhost:4566 s3 cp ./html/index.html s3://my-bucket/index.html
```

---

### 2. اجرای پروژه

```bash
docker compose up -d --build
```

---

### 3. مشاهده نتیجه

مرورگر رو باز کن و برو به:

```
http://localhost:8080
```

👈 اگر همه چیز درست باشه، فایل HTML که از S3 اومده نمایش داده می‌شه.

---

## 🔐 نکات فنی مهم

- `aws-cli` درون کانتینر با استفاده از Dockerfile نصب شده
- متغیرهای AWS (`AWS_ACCESS_KEY_ID` و `AWS_SECRET_ACCESS_KEY`) برای اتصال به LocalStack تنظیم شدن
- از `init.sh` برای رفتار مشابه با EC2 user-data استفاده شده
- کانتینر به شبکه LocalStack وصل شده تا مستقیم به سرویس‌های AWS دسترسی داشته باشه

---

## 🧠 ایده‌های توسعه بیشتر

- اضافه کردن Health Check برای nginx  
- افزودن Basic Auth روی Nginx  
- اتصال به DynamoDB یا Lambda  
- شبیه‌سازی failover یا autoscaling  
- CI/CD برای Deploy کانتینر به سرور دیگر

---

## 🤝 مشارکت

اگر دوست داشتی این پروژه رو گسترش بدی، Pull Request بفرست.  
یا کافیه یه issue باز کنی و با هم روش کار کنیم!

---

## 📇 لایسنس

MIT License

---

> ساخته‌شده با ❤️ توسط [@hjali7](https://github.com/hjali7)
