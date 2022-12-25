from PyQt5 import QtWidgets, QtGui
from PyQt5.QtCore import Qt, QTimer, QDateTime
from PyQt5.QtWidgets import QApplication, QMainWindow
from itertools import cycle
import sys

resolution = [2256, 1440]
background_color = "#2e3440"
default_text_color = "#eceff4"
input_text_color = "#88c0d0"
session_text_color = "#88c0d0"
day_color = "#a3be8c"
am_pm_color = "#b48ead"
separator_color = "#5e6779"

input_window_image = "window.png"
input_window_top_offset = 25
input_window_padding = 60
input_offset = 12

screen_side_margin = 20
screen_bottom_margin = 15

username_password_offset = 40
password_login_offset = 65

font = "Roboto Mono"
font_size = 9

usernames = ["lominoss", "hamid", "assaadeloualji", "aeloualji"]
sessions = ["Awesome", "KDE", "Gnome", "Qtile", "Xmonad"]

class MyWindow(QMainWindow):
    def __init__(self):
        super(MyWindow, self).__init__()

        self.setGeometry(100, 100, resolution[0], resolution[1])
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

        self.password_input = QtWidgets.QLineEdit(self)
        self.password_input.resize(self.input_window.width() - self.password_label.width() - input_offset - input_window_padding * 2, self.password_label.height())
        self.password_input.move(self.password_label.x() + self.password_label.width() + input_offset, self.password_label.y())
        self.password_input.setEchoMode(QtWidgets.QLineEdit.Password)
        self.password_input.setStyleSheet("color: {0}; border: 0; lineedit-password-character: 10033; selection-background-color: {0}; selection-color: {2};".format(input_text_color, input_text_color, background_color))

        self.username_label = QtWidgets.QLabel(self)
        self.username_label.setText("Username:")
        self.username_label.adjustSize()
        self.username_label.move(self.password_label.x(), self.password_label.y() - username_password_offset)

        self.username_cycle = cycle(usernames)
        self.current_username = next(self.username_cycle)

        self.username_button = QtWidgets.QPushButton(self)
        self.username_button.setText(self.current_username)
        self.username_button.resize(self.calculateSize(self.username_button.text()))
        self.username_button.setCursor(QtGui.QCursor(Qt.PointingHandCursor))
        self.username_button.move(self.username_label.x() + self.username_label.width() + input_offset, self.username_label.y())
        self.username_button.setStyleSheet("color: {0}; border: 0;".format(input_text_color))
        self.username_button.clicked.connect(self.changeUsername)

        self.showhide_button = QtWidgets.QPushButton(self)
        self.showhide_button.setText("Show Password")
        self.showhide_button.setCursor(QtGui.QCursor(Qt.PointingHandCursor))
        self.showhide_button.resize(self.calculateSize(self.showhide_button.text()))
        self.showhide_button.move(self.width() // 2 - self.input_window.width() // 2 + input_window_padding, self.password_label.y() + password_login_offset)
        self.showhide_button.setStyleSheet("text-align: left; border: 0;")
        self.showhide_button.clicked.connect(self.showHide)
        
        self.login_button = QtWidgets.QPushButton(self)
        self.login_button.setText("Login")
        self.login_button.setCursor(QtGui.QCursor(Qt.PointingHandCursor))
        self.login_button.resize(self.calculateSize(self.login_button.text()))
        self.login_button.move(self.width() // 2 + self.input_window.width() // 2 - input_window_padding - self.login_button.width(), self.password_label.y() + password_login_offset)
        self.login_button.setStyleSheet("border: 0;")

        self.time_label = QtWidgets.QLabel(self)
        self.showTime()

        timer = QTimer(self)
        timer.timeout.connect(self.showTime)
        timer.start(15000)

        self.session_cycle = cycle(sessions)
        self.current_session = next(self.session_cycle)

        self.session_label = QtWidgets.QLabel(self)
        self.session_label.setText("Session:")
        self.session_label.adjustSize()
        self.session_label.move(self.input_window.x(), self.input_window.y() - 40)

        self.session_button = QtWidgets.QPushButton(self)
        self.session_button.setText(self.current_session)
        self.session_button.setCursor(QtGui.QCursor(Qt.PointingHandCursor))
        self.session_button.resize(self.calculateSize(self.session_button.text()))
        self.session_button.move(self.session_label.x() + self.session_label.width() + input_offset, self.session_label.y())
        self.session_button.setStyleSheet("border: 0; color: {0};".format(session_text_color))
        self.session_button.clicked.connect(self.changeSession)

        self.status_label = QtWidgets.QLabel(self)
        self.status_label.setText("Incorrect Password")
        self.status_label.adjustSize()
        self.status_label.move(self.width() // 2 - self.status_label.width() // 2, self.input_window.y() + self.input_window.height() + 40)
        # self.status_label.hide()

    def calculateSize(self, text):
        self.size_label.setText(text)
        self.size_label.adjustSize()
        return self.size_label.size()

    def showHide(self):
        if self.password_input.echoMode() == QtWidgets.QLineEdit.Password:
            self.password_input.setEchoMode(QtWidgets.QLineEdit.Normal)
            self.showhide_button.setText("Hide Password")

        else:
            self.password_input.setEchoMode(QtWidgets.QLineEdit.Password)
            self.showhide_button.setText("Show Password")

        self.showhide_button.resize(self.calculateSize(self.showhide_button.text()))

    def showTime(self):
        current_time = QDateTime.currentDateTime()
        label_time = current_time.toString('ddd, MMM {1}dd{0} {2}·{0} hh:mm {3}AP{0}')

        label_time = label_time.replace("{0}", "</font>")
        label_time = label_time.replace("{1}", '<font color="{0}">'.format(day_color))
        label_time = label_time.replace("{2}", '<font color="{0}">'.format(separator_color))
        label_time = label_time.replace("{3}", '<font color="{0}">'.format(am_pm_color))

        self.time_label.setText(label_time)
        self.time_label.adjustSize()
        self.time_label.move(self.input_window.x() + self.input_window.width() - self.time_label.width(), self.input_window.y() - 40)

    def changeSession(self):
        self.current_session = next(self.session_cycle)
        self.session_button.setText(self.current_session)
        self.session_button.resize(self.calculateSize(self.session_button.text()))

    def changeUsername(self):
        self.current_username = next(self.username_cycle)
        self.username_button.setText(self.current_username)
        self.username_button.resize(self.calculateSize(self.username_button.text()))

def window():
    app = QApplication(sys.argv)
    app.setFont(QtGui.QFont(font, font_size))

    win = MyWindow()
    win.show()

    sys.exit(app.exec_())

if __name__ == "__main__":
    window()
