from PyQt5 import QtWidgets, QtGui
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QApplication, QMainWindow
import sys

resolution = [1920, 1080]
background_color = "#2e3440"
default_text_color = "#eceff4"

input_window_image = "window.png"
input_window_top_offset = 25
input_window_padding = 60
input_field_offset = 15

username_password_offset = 40
password_login_offset = 65

font = "Roboto Mono"
font_size = 10

default_username = "lominoss"

class MyWindow(QMainWindow):
    def __init__(self):
        super(MyWindow, self).__init__()

        self.setGeometry(0, 0, resolution[0], resolution[1])
        self.setWindowTitle("Test")
        self.setStyleSheet("background-color: {0}; color: {1};".format(background_color, default_text_color))
        self.setFont(QtGui.QFont(font, font_size))

        self.initUI()
    
    def initUI(self):
        self.size_label = QtWidgets.QLabel(self)
        self.size_label.hide()

        self.input_window = QtWidgets.QLabel(self)
        self.input_window_image = QtGui.QPixmap(input_window_image)
        self.input_window.setPixmap(self.input_window_image)
        self.input_window.adjustSize()
        self.input_window.move(self.width() // 2 - self.input_window.width() // 2, self.height() // 2 - self.input_window.height() // 2)

        self.password_label = QtWidgets.QLabel(self)
        self.password_label.setText("Password:")
        self.password_label.adjustSize()
        self.password_label.move(self.width() // 2 - self.input_window.width() // 2 + input_window_padding, self.height() // 2 - input_window_top_offset // 2)

        self.password_field = QtWidgets.QLineEdit(self)
        self.password_field.resize(self.input_window.width() - self.password_label.width() - input_field_offset - input_window_padding * 2, self.password_label.height())
        self.password_field.move(self.password_label.x() + self.password_label.width() + input_field_offset, self.password_label.y())
        self.password_field.setEchoMode(QtWidgets.QLineEdit.Password)
        self.password_field.setStyleSheet("color: #88c0d0; border: 0; lineedit-password-character: 10033; selection-background-color: #88c0d0; selection-color: #2e3440;")

        self.username_label = QtWidgets.QLabel(self)
        self.username_label.setText("Username:")
        self.username_label.adjustSize()
        self.username_label.move(self.password_label.x(), self.password_label.y() - username_password_offset)

        self.username_field = QtWidgets.QLineEdit(self)
        self.username_field.setText(default_username)
        self.username_field.resize(self.input_window.width() - self.username_label.width() - input_field_offset - input_window_padding * 2, self.username_label.height())
        self.username_field.move(self.username_label.x() + self.username_label.width() + input_field_offset, self.username_label.y())
        self.username_field.setStyleSheet("color: #88c0d0; border: 0; selection-background-color: #88c0d0; selection-color: #2e3440;")

        self.showhide_button = QtWidgets.QPushButton(self)
        self.showhide_button.setText("Show Password")
        self.showhide_button.setCursor(QtGui.QCursor(Qt.PointingHandCursor))
        self.showhide_button.resize(self.calculateSize(self.showhide_button.text()))
        self.showhide_button.move(self.width() // 2 - self.input_window.width() // 2 + input_window_padding, self.password_label.y() + password_login_offset)
        self.showhide_button.setStyleSheet("text-align: left; border: 0;")
        self.showhide_button.clicked.connect(self.showhide)
        
        self.login_button = QtWidgets.QPushButton(self)
        self.login_button.setText("Login")
        self.login_button.setCursor(QtGui.QCursor(Qt.PointingHandCursor))
        self.login_button.resize(self.calculateSize(self.login_button.text()))
        self.login_button.move(self.width() // 2 + self.input_window.width() // 2 - input_window_padding - self.login_button.width(), self.password_label.y() + password_login_offset)
        self.login_button.setStyleSheet("text-align: right; border: 0;")

    def calculateSize(self, text):
        self.size_label.setText(text)
        self.size_label.adjustSize()
        return self.size_label.size()

    def showhide(self):
        if self.password_field.echoMode() == QtWidgets.QLineEdit.Password:
            self.password_field.setEchoMode(QtWidgets.QLineEdit.Normal)
            self.showhide_button.setText("Hide Password")

        else:
            self.password_field.setEchoMode(QtWidgets.QLineEdit.Password)
            self.showhide_button.setText("Show Password")

        self.showhide_button.resize(self.calculateSize(self.showhide_button.text()))

def window():
    app = QApplication(sys.argv)
    app.setFont(QtGui.QFont(font, font_size))

    win = MyWindow()
    win.show()

    sys.exit(app.exec_())

if __name__ == "__main__":
    window()
