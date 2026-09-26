# استخدام نظام أوبونتو مصغر ومستقر كبنية أساسية
FROM ubuntu:22.04

# منع النوافذ التفاعلية أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تثبيت متطلبات فري راديوس وبايثون وقاعدة البيانات
RUN apt-get update && apt-get install -y \
    freeradius \
    freeradius-mysql \
    mariadb-server \
    python3 \
    python3-pip \
    && rm -rf /lib/apt/lists/*

# تحديد مسار العمل داخل الحاوية
WORKDIR /app

# تثبيت مكتبات بايثون المطلوبة للوحة التحكم
RUN pip3 install flask mysql-connector-python gunicorn

# نسخ ملفات المشروع إلى السيرفر
COPY app.py /app/app.py

# فتح البورتات: 80 للوحة التحكم، و 1812/1813 للراديوس والمايكروتك
EXPOSE 80/tcp
EXPOSE 1812/udp
EXPOSE 1813/udp

# أمر تشغيل السيرفر والراديوس معاً عند الإقلاع
CMD service mysql start && service freeradius start && gunicorn -b 0.0.0.0:80 app:app
