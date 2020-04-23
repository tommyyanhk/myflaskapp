from flask import Flask, render_template, flash, redirect, url_for, session, logging, request, current_app
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from flask_wtf.file import FileField, FileRequired
from passlib.hash import sha256_crypt
#from data import Rents
from functools import wraps 
from flask_simplelogin import is_logged_in 
import os
import secrets
app = Flask(__name__)
app.secret_key = "Flask App"

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "root"
app.config["MYSQL_DB"] = "myflaskapp"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)

#Rents = Rents()

def save_images(photo):
	hash_photo = secrets.token_urlsafe(10)
	_, file_extention = os.path.splitext(photo.filename)
	photo_name = hash_photo + file_extention
	file_path = os.path.join(current_app.root_path, 'static/images', photo_name)
	photo.save(file_path)
	return photo_name

@app.route("/")
def index():
	return render_template("home.html")

@app.route("/about")
def about():
	return render_template("about.html")

@app.route("/rents")
def rents():
	cur = mysql.connection.cursor()
	result = cur.execute("SELECT * FROM rents")
	rents = cur.fetchall()
	if result > 0:
		return render_template("rents.html", rents = rents)
	else:
		msg =- "No Items Found"
		return render_template("rents.html", msg = msg)

@app.route("/rent/<string:id>/")
def rent(id):
	cur = mysql.connection.cursor()
	result = cur.execute("SELECT * FROM rents WHERE id = %s", [id])
	rent = cur.fetchone()

	return render_template('rent.html', rent = rent)

class RegisterForm(Form):
	name=StringField("Name", [validators.length(min=1, max=50)])
	username=StringField("Username", [validators.length(min=4, max=25)])
	email=StringField("Email", [validators.length(min=6, max=50)])
	password=PasswordField("Password", [validators.DataRequired(), validators.EqualTo("confirm", message = "Passwords do not match")])
	confirm=PasswordField("Confirm Password")

@app.route("/register", methods=["GET", "POST"])
def register():
	form = RegisterForm(request.form)
	if request.method == "POST" and form.validate():
		#return render_template("register.html")
		name = form.name.data
		email = form.email.data
		username = form.username.data
		password = sha256_crypt.encrypt(str(form.password.data))

		cur = mysql.connection.cursor()
		cur.execute("INSERT INTO users(name, email, username, password) VALUES (%s, %s, %s, %s)", (name, email, username, password))
		
		mysql.connection.commit()

		cur.close()

		flash("You are now registered and you can log in", "success")
		return redirect(url_for("index"))
	return render_template("register.html", form = form)

@app.route('/login', methods=["GET", "POST"])
def login():
	if request.method == "POST":
		username = request.form["username"]
		password_candidate = request.form["password"]

		cur = mysql.connection.cursor()

		result = cur.execute("SELECT * FROM users WHERE username = %s", [username])
		if result > 0:
			data = cur.fetchone()
			password = data["password"]

			if sha256_crypt.verify(password_candidate, password):
				app.logger.info("PASSWORD MATCHED")
				session["logged_in"] = True
				session["username"] = username

				flash("You  are now logged in", "success")
				return redirect(url_for("dashboard"))
			else:
				error = "Invaild login"
				return render_template("login.html", error = error)
			cur.close()
		else:
			error = "Username Not Found"
			return render_template("login.html", error = error)
	return render_template("login.html")

@app.route("/logout")
def logout():
	session.clear()
	flash("You are logged out", "success")
	return redirect(url_for("login"))

def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if "logged_in" in session:
			return f(*args, **kwargs)
		else:
			flash("Unauthorized, Please LogIn", "danger")
			return redirect(url_for("login"))
	return wrap

@app.route("/dashboard")
@is_logged_in
def dashboard():
		cur = mysql.connection.cursor()

		result = cur.execute("SELECT * FROM rents")

		rents = cur.fetchall()

		if result > 0:
			return render_template("dashboard.html", rents = rents)
		else:
			msg = "No Items Found"
			return render_template("dashboard.html", msg = msg)

		cur.close()
		return render_template("dashboard.html")


#class itemform(Form):
	#title = StringField("Title", [validators.length(min=1, max=100)])
	#body = TextAreaField("Body", [validators.length(min=1, max=2000)])
	#img = FileField("Images", validators=[FileRequired()]) 

@app.route("/add_item", methods=["GET", "POST"])
@is_logged_in
def add_item():
	#form = itemform(request.form)
	if request.method == "POST" :
		title = request.form['title']
		body = request.form['body']
		img = save_images(request.files['img'])

		cur = mysql.connection.cursor()

		cur.execute("INSERT INTO rents (title, body, seller, img)" "VALUES (%s, %s, %s, %s)", (title, body, session["username"], img))

		mysql.connection.commit()

		cur.close()

		flash("Item Created", "success")
		return redirect(url_for("dashboard"))
	return render_template("add_item.html")

@app.route("/edit_item/<int:id>", methods=["GET", "POST"])
@is_logged_in
def edit_item(id):

	if request.method == "POST":
		title=request.form["title"]
		body=request.form["body"]
		img = save_images(request.files["img"])

		
		cur = mysql.connection.cursor()

		cur.execute("UPDATE rents SET title=%s, body=%s, img=%s WHERE id=%s", (title, body,img, id))

		mysql.connection.commit()

		cur.close()

		flash("Item Updated", "success")
		return redirect(url_for("dashboard"))

	cur = mysql.connection.cursor()
	cur.execute("SELECT * FROM rents WHERE id=%s", [id])
	rent = cur.fetchone()
	return render_template('edit_item.html', rent=rent)

@app.route("/delete_rent/<string:id>", methods=["POST"])
def  delete_rent(id):
	cur = mysql.connection.cursor()
	cur.execute("DELETE FROM rents WHERE id=%s", [id])
	mysql.connection.commit()
	cur.close()
	flash("Item Deleted", "success")
	return redirect(url_for("dashboard"))

if __name__ == "__main__":
	app.debug = True
	app.run()