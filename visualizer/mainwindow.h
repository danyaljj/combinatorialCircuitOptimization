#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "dialog.h"

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow {
    Q_OBJECT
public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();


protected:
    void changeEvent(QEvent *e);

private:
    Ui::MainWindow *ui;
    Dialog d;
    std::vector <int> gate_pos_x;
    std::vector <int> gate_pos_y;

    int cleaned;
    int refereshed;
    int input_number;

    void darwAGate(int x,int y, int gate_code);
    void set_connection_numbers();
    void runGateIllustration();
    void drawGateConnectionNumber(int x, int y, int in1_con_num, int in2_con_num
                                            , std::vector<int> out_con_num, int gate_type);
    void drawANumber(int x, int y, int num);
    bool parseFile(std::string file_address);
    void paintEvent( QPaintEvent * event );

private slots:
    void on_actionAbout_triggered();
    void on_actionExit_triggered();
    void on_pushButton_clicked();

};

#endif // MAINWINDOW_H
