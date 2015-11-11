#include <QtGui/QApplication>
#include <QtCore/QCoreApplication>
#include "mainwindow.h"
#include <QDesktopWidget>
#include <QLabel>
#include <QPushButton>
#include <QFile>
#include <QTextStream>
#include <fstream>
#include <iostream>
#include <vector>
#include <digital_gate.h>
#include <Parser.h>
#include <QTextEdit>
#include <QHBoxLayout>
#include <sstream>
#include "dialog.h"


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
#if 1
      MainWindow w;
      w.show();
      //Dialog d;
      //d.show();
#else
    const int HEIGHT = 650;
    const int WIDTH = 1000;

    QWidget window;
    window.resize(WIDTH,HEIGHT);
    center(&window, WIDTH, HEIGHT);
    window.setWindowTitle("Digital Gate Illutrator");
    window.setWindowIcon(QIcon("icon.png"));
    window.show();

#if 0  //testing file parser
    QTextEdit *edit1 = new QTextEdit("");
    QHBoxLayout *layout = new QHBoxLayout();
    layout->addWidget(edit1);
    window.setLayout(layout);
    if(parseFile("config.txt"))  //parsed sucessfuly !
    {
        stringstream ss;
        digital_gate dg_gate_tmp;
        edit1->setText("File parsed! \n");
        for(unsigned int i = 0; i < dg_gate.size(); i++ )
        {
            dg_gate_tmp = dg_gate[i];
            ss << dg_gate_tmp.get_gate_pos_x() << " ";
        }
        edit1->setText(QString::fromStdString(ss.str()));

    }
    else;
       edit1->setText("File parse error! ");
#endif

    //QPushButton *push_1 = new QPushButton("+");
    //QPushButton *push_2 = new QPushButton("-");
#endif
    return a.exec();
}

