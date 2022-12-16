from PyQt5 import QtWidgets, QtGui
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QApplication, QMainWindow
import sys

input_window_padding = 60
input_window_top_offset = 25
input_field_offset = 12

def draw_window():
    # App init
    app = QApplication(sys.argv)
    app.setFont(QtGui.QFont("Fira Code", 9))

    # Main window
    window = QMainWindow()
    window.setGeometry(500, 500, 2256, 1504)
    window.setWindowTitle("Test")
    window.setStyleSheet("background-color: #2e3440; color: #eceff4;")

    # Current time widget
    time = QtWidgets.QLabel(window)
    time.setText('08:36 <font color="#b48ead">AM</font>')
    time.resize(500, time.height())
    time.setAlignment(Qt.Alignment(Qt.AlignRight))
    time.move(window.width() - time.width() - 20, window.height() - time.height() - 8)

    # Selected session widget
    session = QtWidgets.QLabel(window)
    session.setText('Session: <font color="#88c0d0">Awesome</font>')
    session.resize(500, session.height())
    session.move(20, window.height() - time.height() - 8)

    # Center input window
    input_window = QtWidgets.QLabel(window)
    input_window_image = QtGui.QPixmap("window.png")
    input_window.setPixmap(input_window_image)
    input_window.resize(input_window_image.width(), input_window_image.height())
    input_window.move(window.width() // 2 - (input_window.width() // 2), window.height() // 2 - (input_window.height() // 2))

    print(input_window.width())
    print(input_window.height())

    # Password label
    password_label = QtWidgets.QLabel(window)
    password_label.setText('Password:')
    password_label.adjustSize()
    password_label.move(window.width() // 2 - input_window.width() // 2 + input_window_padding, window.height() // 2 - input_window_top_offset // 2)
    # password_label.setStyleSheet("background-color: red;")

    # Password field
    password_field = QtWidgets.QLineEdit(window)
    password_field.resize(input_window.width() - password_label.width() - input_field_offset - input_window_padding * 2, password_label.height())
    password_field.move(password_label.x() + password_label.width() + input_field_offset, password_label.y())
    password_field.setEchoMode(QtWidgets.QLineEdit.Password)
    password_field.setStyleSheet("color: #88c0d0; border: 0; caret-color: #88c0d0;")

    # Username label
    username_label = QtWidgets.QLabel(window)
    username_label.setText('Username:')
    username_label.adjustSize()
    username_label.move(password_label.x(), password_label.y() - 35)
    # username_label.setStyleSheet("background-color: red;")

    # Show/hide toggle
    show_hide = QtWidgets.QLabel(window)
    show_hide.setText('Show Password')
    show_hide.adjustSize()
    show_hide.setAlignment(Qt.Alignment(Qt.AlignRight))
    show_hide.move(window.width() // 2 + input_window.width() // 2 - input_window_padding - show_hide.width(), password_label.y() + 60)
    # show_hide.setStyleSheet("color: #4c566a;")
    # show_hide.setStyleSheet("background-color: red;")

    window.show()
    sys.exit(app.exec_())

draw_window()