from flask import Flask, render_template, request, redirect, jsonify
import mysql.connector
import secrets
import string

app = Flask(__name__)

# إعدادات الاتصال بقاعدة بيانات الراديوس على السيرفر
db_config = {
    'host': 'localhost',
    'user': 'radius_admin',
    'password': 'YourSecurePassword2026!!',
    'database': 'radius_db'
}

def generate_random_coupon(length=6):
    characters = string.ascii_lowercase + string.digits
    return ''.join(secrets.choice(characters) for _ in range(length))

@app.route('/api/generate_cards', methods=['POST'])
def generate_cards():
    """توليد كروت ميكروتك جماعية وحفظها في سيرفر الراديوس"""
    data = request.json
    count = data.get('count', 10)
    profile_speed = data.get('speed_limit', '5M/5M') # بروفايل السرعة للميكروتك
    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    generated_cards = []
    for _ in range(count):
        username = generate_random_coupon()
        password = username # كرت بكلمة مرور مماثلة للاسم
        
        # 1. إدخال بيانات تسجيل الدخول
        cursor.execute("INSERT INTO radcheck (username, attribute, op, value) VALUES (%s, 'Cleartext-Password', '==', %s)", (username, password))
        # 2. تعيين السرعة لراوتر المايكروتك عبر الراديوس
        cursor.execute("INSERT INTO radreply (username, attribute, op, value) VALUES (%s, 'Mikrotik-Rate-Limit', '=', %s)", (username, profile_speed))
        
        generated_cards.append(username)
        
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"status": "success", "cards": generated_cards})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
