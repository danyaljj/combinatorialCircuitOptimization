#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QLabel>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <Parser.h>
#include <digital_gate.h>
#include <sstream>
#include <QDesktopWidget>
#include <QPixmap>
#include <QImage>
#include <QPainter>
#include <algorithm>
#include <QLayout>
#include <QHBoxLayout>
#include <list>
#include "dialog.h"
#include <QDebug>

//Global variables:
std::vector <digital_gate> dg_gate; // list of digital gates
int gate_table_h;
int gate_table_w;


//QPixmap pixmap_wire, pixmap_not, pixmap_and, pixmap_or, pixmap_nand, pixmap_nor, pixmap_xor, pixmap_xnor;
const int gate_height_pixel = 44;
const int gate_width_pixel = 65;
const int gate_horizantal_dist = 130;
const int gate_vertical_dist = 100;


//Function defines:
bool parseFile(std::string file_address);
void center( QWidget *window, int w, int h );
bool gateSortMethod(const digital_gate &d1, const digital_gate &d2 );

MainWindow::MainWindow(QWidget *parent) :
        QMainWindow(parent),
        ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    //move to center:
    QDesktopWidget *desktop = QApplication::desktop();
    int screenWidth = desktop->width();
    int screenHeight = desktop->height();
    this->setGeometry(screenWidth/2, screenHeight/2, screenWidth-10, screenHeight-40);
    this->move((screenWidth-this->size().width())/2,
               (screenHeight-this->size().height())/2);  // set pos in center of window

    //fix size:
    //this->setFixedWidth( this->size().width());
    //this->setFixedHeight (this->size().height());

    //this->setFixedSize(screenWidth, screenHeight);
    this->setWindowTitle("Digital Gate Illustrator");
    this->setWindowIcon(QIcon("icon.png"));

    //Initialization:
    runGateIllustration();
    gate_table_h = 0;
    gate_table_w = 0;

    refereshed = 0;
    cleaned = 0;
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::changeEvent(QEvent *e)
{
    QMainWindow::changeEvent(e);
    switch (e->type()) {
    case QEvent::LanguageChange:
        ui->retranslateUi(this);
        break;
    default:
        break;
    }
}


void MainWindow::runGateIllustration()
{
    // Parse:
    if(parseFile("../input.txt"))
    {
        //parsed sucessfuly !
    }
    else
        ui->label->setText("File Parse Error!");

    // set connection numbers:
    set_connection_numbers();
/*
    //draw gates:
    int x;
    int y;
    digital_gate dg_gate_tmp;
    for(unsigned int i=0; i < dg_gate.size(); i++)
    {
        dg_gate_tmp = dg_gate[i];
        x = gate_horizantal_dist*dg_gate_tmp.get_gate_pos_x()-40;
        y = gate_vertical_dist*dg_gate_tmp.get_gate_pos_y()+10;
        gate_pos_x.push_back( x );
        gate_pos_y.push_back( y );
        darwAGate(x, y, dg_gate_tmp.get_gate_type());

        drawGateConnectionNumber(x,y,dg_gate_tmp.get_input1_connection_number()
                                 ,dg_gate_tmp.get_input2_connection_number()
                                 ,dg_gate_tmp.get_output_connection_number()
                                 ,dg_gate_tmp.get_gate_type());
    }
*/
    // call paintEvent
    this->repaint();
    this->update();


#if 0 //testing line drawing:
    QPen pen(Qt::black, 2, Qt::SolidLine);
    QPainter painter(this);
    painter.setPen(pen);
    painter.drawLine(20, 40, 600, 500);

    QLineF line(10.0, 280.0, 90.0, 420.0);
    //QPainter(this);
    painter.drawLine(line);
#endif

}

void MainWindow::paintEvent( QPaintEvent * event )
{
    QPainter painter(this);


    //qDebug() << "refereshed" << refereshed << endl;
    //qDebug() << "Cleaned" << cleaned << endl;

    //Clear window:
    if( cleaned < refereshed )
    {
        QRect rect(10,50,this->width(),this->height());
        QColor col = QColor::fromHsv(0,0,240);
        painter.setBrush(QBrush(col));
        painter.setPen(QPen(col, 0));

        painter.drawRect(rect);
        cleaned ++;
    }

    painter.setPen(QPen(Qt::black, 0));

    //draw gates:
    int x;
    int y;
    digital_gate dg_gate_tmp;
    std::vector<int> out_con_num;
    for(unsigned int i=0; i < dg_gate.size(); i++)
    {
        dg_gate_tmp = dg_gate[i];
        x = gate_horizantal_dist*dg_gate_tmp.get_gate_pos_x()-40;
        y = gate_vertical_dist*dg_gate_tmp.get_gate_pos_y()+10;
        gate_pos_x.push_back( x );
        gate_pos_y.push_back( y );
        //darwAGate(x, y, dg_gate_tmp.get_gate_type());

        //load images:
        QPixmap pixmap_wire("../pix/WIRE.png"), pixmap_not("../pix/NOT.png")
                   ,pixmap_and("../pix/AND.png"), pixmap_or("../pix/OR.png")
                   ,pixmap_nand("../pix/NAND.png"), pixmap_nor("../pix/NOR.png")
                   ,pixmap_xor("../pix/XOR.png"), pixmap_xnor("../pix/XNOR.png");

        switch(dg_gate_tmp.get_gate_type())
        {
        case 0:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_wire);
            break;
        case 1:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_not);
            break;
        case 2:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_and);
            break;
        case 3:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_or);
            break;
        case 4:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_nand);
            break;
        case 5:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_nor);
            break;
        case 6:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_xor);
            break;
        case 7:
            painter.drawPixmap(x, y, gate_width_pixel, gate_height_pixel, pixmap_xnor);
            break;
        default:
            qDebug() << "gate type error!" << endl;
        }

        // ------------------------------------------------------------------------------------
        // draw Gate numbers:
        // Gate Types: 0:WIRE 1:NOT 2:AND 3:OR 4:NAND 5:NOR 6:XOR 7:XNOR
        y += 14;
        if( dg_gate_tmp.get_gate_type() == 1 ) //"NOT" gate
        {
            if( dg_gate_tmp.get_input1_connection_number() != 0 )
                painter.drawText(x,y+18,QString::number(dg_gate_tmp.get_input1_connection_number()));
            else if(dg_gate_tmp.get_gate_input1_x() == 0 )
                painter.drawText(x,y+18,QString(char(dg_gate_tmp.get_gate_input1_y()+64)));
        }
        else if ( dg_gate_tmp.get_gate_type() == 7 || dg_gate_tmp.get_gate_type() == 6 )  //XOR + XNOR
        {
            if( dg_gate_tmp.get_input1_connection_number() != 0 )
                painter.drawText(x-8,y-4,QString::number(dg_gate_tmp.get_input1_connection_number()));
            else if(dg_gate_tmp.get_gate_input1_x() == 0 )
                painter.drawText(x-8,y-4,QString(char(dg_gate_tmp.get_gate_input1_y()+64)));

            if( dg_gate_tmp.get_input2_connection_number() != 0 )
                painter.drawText(x-8,y+28,QString::number(dg_gate_tmp.get_input2_connection_number()));
            else if(dg_gate_tmp.get_gate_input2_x() == 0 )
                painter.drawText(x-8,y+28,QString(char(dg_gate_tmp.get_gate_input2_y()+64)));

        }
        else if(  dg_gate_tmp.get_gate_type() == 3 || dg_gate_tmp.get_gate_type() == 5 ) // OR + NOR
        {
            if( dg_gate_tmp.get_input1_connection_number() != 0 )
                painter.drawText(x-4,y-4,QString::number(dg_gate_tmp.get_input1_connection_number()));
            else if(dg_gate_tmp.get_gate_input1_x() == 0 )
                painter.drawText(x-4,y-4,QString(char(dg_gate_tmp.get_gate_input1_y()+64)));

            if( dg_gate_tmp.get_input2_connection_number() != 0 )
                painter.drawText(x-4,y+28,QString::number(dg_gate_tmp.get_input2_connection_number()));
            else if(dg_gate_tmp.get_gate_input2_x() == 0 )
                painter.drawText(x-4,y+28,QString(char(dg_gate_tmp.get_gate_input2_y()+64)));
        }
        else
        {
            if( dg_gate_tmp.get_input1_connection_number() != 0 )
                painter.drawText(x,y-4,QString::number(dg_gate_tmp.get_input1_connection_number()));
            else if(dg_gate_tmp.get_gate_input1_x() == 0 )
                painter.drawText(x,y-4,QString(char(dg_gate_tmp.get_gate_input1_y()+64)));

            if( dg_gate_tmp.get_input2_connection_number() != 0 )
                painter.drawText(x,y+28,QString::number(dg_gate_tmp.get_input2_connection_number()));
            else if(dg_gate_tmp.get_gate_input2_x() == 0 )
                painter.drawText(x,y+28,QString(char(dg_gate_tmp.get_gate_input2_y()+64)));
        }

        // output:
        out_con_num = dg_gate_tmp.get_output_connection_number();

        for(unsigned int i=0; i<out_con_num.size(); i++)
        {
            /*
           if( out_con_num.size() == i+1  )
              drawANumber(x+62,y+5,out_con_num[i]);
            else
           */
            painter.drawText(x+65,y+5+9*i,QString::number(out_con_num[i]));
        }
    }


    //------------------------------------------------------------------------
    // draw wires:
    int x_i, y_i, x_j, y_j;
    bool isConnected_1 = false;
    bool isConnected_2 = false;

    std::vector <int> out_con_num_tmp;
    digital_gate dg_gate_tmp_i, dg_gate_tmp_j ;
    painter.setPen(QPen(Qt::black, 2));
    //painter.setPen(QPen(Qt::white, 15));
    
    static QPointF points[6];
    //p.setPen(QColor("red"));

    static int random_offset;
    for(unsigned int i=0; i < dg_gate.size(); i++)  // input
    {
        dg_gate_tmp_i = dg_gate[i];
        x_i = gate_horizantal_dist*dg_gate_tmp_i.get_gate_pos_x()-40;
        y_i = gate_vertical_dist*dg_gate_tmp_i.get_gate_pos_y()+10;

        for(unsigned int j=0; j < dg_gate.size(); j++) // output
        {
            isConnected_1 = false;
            isConnected_2 = false;

            dg_gate_tmp_j = dg_gate[j];
            x_j = gate_horizantal_dist*dg_gate_tmp_j.get_gate_pos_x()-40;
            y_j = gate_vertical_dist*dg_gate_tmp_j.get_gate_pos_y()+10;

            out_con_num_tmp = dg_gate_tmp_j.get_output_connection_number();
            for( unsigned int it=0; it<out_con_num_tmp.size(); it++ )
            {
                if ( dg_gate_tmp_i.get_input1_connection_number() == out_con_num_tmp[it] )
                    isConnected_1 = true;

                if ( dg_gate_tmp_i.get_input2_connection_number() == out_con_num_tmp[it] )
                    isConnected_2 = true;
            }

            if( dg_gate[i].get_gate_type() != 1 )  // No Wire Gate
            {
                if( isConnected_1 )
                {
                    if( abs(x_i - x_j) /gate_horizantal_dist < 1.2  )  // Adjacent
                    {
                        random_offset = (qrand()% 30)-15;
                        points[0] = QPointF(x_i+2, y_i+12);
                        points[1] = QPointF((x_i+x_j+62)/2+random_offset, y_i+12);
                        points[2] = QPointF((x_i+x_j+62)/2+random_offset, y_j+22);
                        points[3] = QPointF(x_j+65, y_j+22);
                        painter.drawPolyline(points, 4);

                        for( int i=1; i<3; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                    else
                    {
                        random_offset = (qrand()% 30)-15;
                        //qDebug() << "imadam inja!";
                        points[0] = QPointF(x_i+2, y_i+12);
                        points[1] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset, y_i+12);
                        points[2] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset , y_i+12 + gate_vertical_dist/2+random_offset );
                        points[3] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_i+12 + gate_vertical_dist/2+random_offset);
                        points[4] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_j+22);
                        points[5] = QPointF(x_j+65, y_j+22);
                        painter.drawPolyline(points, 6);

                        for( int i=1; i<5; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                }

                if( isConnected_2 )
                {
                    if( abs(x_i - x_j) /gate_horizantal_dist < 1.2  )  // Adjacent
                    {
                        random_offset = (qrand()% 30)-15;
                        points[0] = QPointF(x_i+2, y_i+32);
                        points[1] = QPointF((x_i+x_j+62)/2+random_offset, y_i+32);
                        points[2] = QPointF((x_i+x_j+62)/2+random_offset, y_j+22);
                        points[3] = QPointF(x_j+65, y_j+22);
                        //QPainter painter_p(this);
                        painter.drawPolyline(points, 4);
                        //painter.setPen();
                        for( int i=1; i<3; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                    else
                    {
                        random_offset = (qrand()% 30)-15;
                        points[0] = QPointF(x_i+2, y_i+32);
                        points[1] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset, y_i+32);
                        points[2] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset, y_i+32 + gate_vertical_dist/2+random_offset);
                        points[3] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_i+32 + gate_vertical_dist/2+random_offset);
                        points[4] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_j+22);
                        points[5] = QPointF(x_j+65, y_j+22);
                        painter.drawPolyline(points, 6);
                        for( int i=1; i<5; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                }
            }
            else  // When "Not" Wire
            {

                if( isConnected_1 )
                {
                    if( abs(x_i - x_j) /gate_horizantal_dist < 1.2  )  // Adjacent
                    {

                        random_offset = (qrand()% 30)-15;
                        points[0] = QPointF(x_i+2, y_i+22);
                        points[1] = QPointF((x_i+x_j+62)/2+random_offset, y_i+22);
                        points[2] = QPointF((x_i+x_j+62)/2+random_offset, y_j+22);
                        points[3] = QPointF(x_j+65, y_j+22);
                        painter.drawPolyline(points, 4);
                        for( int i=1; i<3; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                    else
                    {
                        random_offset = (qrand()% 30)-15;
                        //qDebug() << "imadam inja!";
                        points[0] = QPointF(x_i+2, y_i+22);
                        points[1] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset, y_i+22);
                        points[2] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset , y_i+22 + gate_vertical_dist/2+random_offset );
                        points[3] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_i+22 + gate_vertical_dist/2+random_offset);
                        points[4] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_j+22);
                        points[5] = QPointF(x_j+65, y_j+22);
                        painter.drawPolyline(points, 6);
                        for( int i=1; i<5; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                }

                if( isConnected_2 )
                {
                    if( abs(x_i - x_j) /gate_horizantal_dist < 1.2  )  // Adjacent
                    {

                        random_offset = (qrand()% 30)-15;
                        points[0] = QPointF(x_i+2, y_i+22);
                        points[1] = QPointF((x_i+x_j+62)/2+random_offset, y_i+22);
                        points[2] = QPointF((x_i+x_j+62)/2+random_offset, y_j+22);
                        points[3] = QPointF(x_j+65, y_j+22);
                        //QPainter painter_p(this);
                        painter.drawPolyline(points, 4);

                        for( int i=1; i<3; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                    else
                    {

                        random_offset = (qrand()% 30)-15;
                        points[0] = QPointF(x_i+2, y_i+22);
                        points[1] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset, y_i+22);
                        points[2] = QPointF(x_i+2-0.66*gate_horizantal_dist/2+random_offset, y_i+22 + gate_vertical_dist/2+random_offset);
                        points[3] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_i+22 + gate_vertical_dist/2+random_offset);
                        points[4] = QPointF(x_j+65 + 0.55*gate_horizantal_dist/2+random_offset, y_j+22);
                        points[5] = QPointF(x_j+65, y_j+22);
                        painter.drawPolyline(points, 6);

                        for( int i=1; i<5; i++ )
                            painter.drawEllipse(points[i],2,2);
                    }
                }
            }
        }

    }
}
void MainWindow::drawGateConnectionNumber(int x, int y, int in1_con_num, int in2_con_num
                                          , std::vector<int> out_con_num, int gate_type)
{
    // # Gate Types: 0:WIRE 1:NOT 2:AND 3:OR 4:NAND 5:NOR 6:XOR 7:XNOR
    if( gate_type == 1 ) //not gate
        drawANumber(x+4,y+18,in1_con_num);
    else if ( gate_type == 7 || gate_type == 6 )  //XOR + XNOR
    {
        drawANumber(x-4,y-4,in1_con_num);
        drawANumber(x-4,y+28,in2_con_num);
    }
    else if(  gate_type == 3 || gate_type == 5 ) // OR + NOR
    {
        drawANumber(x,y-4,in1_con_num);
        drawANumber(x,y+28,in2_con_num);
    }
    else
    {
        drawANumber(x+4,y-4,in1_con_num);
        drawANumber(x+4,y+28,in2_con_num);
    }

    // output:
    for(unsigned int i=0; i<out_con_num.size(); i++)
    {
        /*
       if( out_con_num.size() == i+1  )
          drawANumber(x+62,y+5,out_con_num[i]);
        else
       */
        drawANumber(x+65,y+5+9*i,out_con_num[i]);
    }
}


void MainWindow::drawANumber(int x, int y, int num)
{
    //QHBoxLayout *h_layout = new QHBoxLayout();
    QLabel *label_tmp = new QLabel(this);
    label_tmp->setGeometry(x,y,20,20);
    label_tmp->setText(QVariant(num).toString());
    label_tmp->show();
    //h_layout->addWidget( label_tmp );
    //this->setLayout(h_layout);
}


void MainWindow::darwAGate(int x,int y,int gate_code)
{
    //load images:
    QPixmap *pixmap_wire = new QPixmap("../pix/WIRE.png"), *pixmap_not = new QPixmap("../pix/NOT.png")
               ,*pixmap_and = new QPixmap("../pix/AND.png"), *pixmap_or = new QPixmap("../pix/OR.png")
               ,*pixmap_nand = new QPixmap("../pix/NAND.png"), *pixmap_nor = new QPixmap("../pix/NOR.png")
               ,*pixmap_xor = new QPixmap("../pix/XOR.png"), *pixmap_xnor = new QPixmap("../pix/XNOR.png");

    QLabel *label_tmp = new QLabel(this);
    label_tmp->setGeometry(x,y,gate_width_pixel,gate_height_pixel);
    //label_tmp->adjustSize();
    switch(gate_code)
    {
    case 0:
        label_tmp->setPixmap(*pixmap_wire);
        break;
    case 1:
        label_tmp->setPixmap(*pixmap_not);
        break;
    case 2:
        label_tmp->setPixmap(*pixmap_and);
        break;
    case 3:
        label_tmp->setPixmap(*pixmap_or);
        break;
    case 4:
        label_tmp->setPixmap(*pixmap_nand);
        break;
    case 5:
        label_tmp->setPixmap(*pixmap_nor);
        break;
    case 6:
        label_tmp->setPixmap(*pixmap_xor);
        break;
    case 7:
        label_tmp->setPixmap(*pixmap_xnor);
        break;
    default:
        label_tmp->setText("gate type error!");
    }
    //label_tmp->move(x,y);
    label_tmp->show();
}

bool gateSortMethod(const digital_gate &d1, const digital_gate &d2 )
{
    // sorting in desending order( based on x pos of gate)
    if( d1.gate_pos_x < d2.gate_pos_x )
        return true;
    return false;
}

bool MainWindow::parseFile(std::string file_address)
{
    std::ifstream inFile(file_address.c_str());
    if (!inFile.good())
    {
        std::cerr
                << "parseFile: **** ERROR **** Could not open file 'passConf'"
                << std::endl;
        return false;
    }
    if( ui->combo_input_type->currentText() == "Input Coding Type 1" )
    {
        char strLine[256], *str;
        //int iNr = 1; // current line in file starting from 1
        Parser pars_obj;

        digital_gate dg_gate_tmp;

        int tmp_int;
        while (inFile.getline(strLine, sizeof(strLine)))
        {
            str = &strLine[0];
            // comment and empty lines should be skipped
            if( !(strLine[0] == '\n' || strLine[0] == '#' || strLine[0]=='\0' ||
                  pars_obj.gotoFirstNonSpace( &str ) == '\0' ) )
            {
                for( int ii = 1 ; ii <= 7 ; ii++ )
                {
                    switch(ii)
                    {
                    case 1:
                        tmp_int = pars_obj.parseFirstInt( &str );
                        dg_gate_tmp.set_gate_pos_x( tmp_int );
                        if( tmp_int > gate_table_w  )
                            gate_table_w = tmp_int;
                        break;
                    case 2:
                        tmp_int = pars_obj.parseFirstInt( &str );
                        dg_gate_tmp.set_gate_pos_y(tmp_int);
                        if( tmp_int > gate_table_h  )
                            gate_table_h = tmp_int;
                        break;
                    case 3:
                        dg_gate_tmp.set_gate_input1_x(pars_obj.parseFirstInt( &str ));
                        break;
                    case 4:
                        dg_gate_tmp.set_gate_input1_y(pars_obj.parseFirstInt( &str ));
                        break;
                    case 5:
                        dg_gate_tmp.set_gate_input2_x(pars_obj.parseFirstInt( &str ));
                        break;
                    case 6:
                        dg_gate_tmp.set_gate_input2_y(pars_obj.parseFirstInt( &str ));
                        break;
                    case 7:
                        dg_gate_tmp.set_gate_type(pars_obj.parseFirstInt( &str ));
                        break;
                    }
                }
            }
            else
                continue;
            dg_gate.push_back(dg_gate_tmp);
        } //While: go one line further

        return true; // successfully parsed!
    }
    else if( ui->combo_input_type->currentText() == "Input Coding Type 2" )
    {
        // To Do !
        return true;
    }
    return true;
}

void MainWindow::on_pushButton_clicked()
{
    // Referesh:
    //QLabel *label = new QLabel(this);
    //    qDebug() << "desktop->width(): " << desktop->width() << endl;
    //    qDebug() << "desktop->height(): " << desktop->height() << endl;
    //label->setGeometry(10,50,this->width(),this->height());
    //label->show();

    //label->setAutoFillBackground(true);
    //label->paintingActive();
    //label->backgroundRole();
    dg_gate.clear();
    runGateIllustration();
    // resource address: :/prefix/print.bmp
    refereshed++;
}

void MainWindow::set_connection_numbers()
{
    //int tmp; //temp variable for connection number
    digital_gate gate_i, gate_j;
    std::vector<int> output_connections; // temp varibale for comparision
    int connection_iter = 1; //starting from 1
    bool increase_connection_number = false;
    for(unsigned int i=0; i<dg_gate.size(); i++) // input
    {
        gate_i = dg_gate[i];
        for(unsigned j=0; j<dg_gate.size(); j++) // gate pos
        {
            gate_j = dg_gate[j];
            increase_connection_number = false; //no

            //input1:
            if( gate_i.get_gate_input1_x() == gate_j.get_gate_pos_x()
                && gate_i.get_gate_input1_y() == gate_j.get_gate_pos_y() ) //connected
                {
                increase_connection_number = true;
                // assign to output:
                output_connections = gate_j.get_output_connection_number();
                if( output_connections.size()== 0 ) //new connection numer
                {
                    output_connections.push_back(connection_iter);
                    gate_j.set_output_connection_number(output_connections);
                    dg_gate[j].set_output_connection_number(output_connections);
                } // or ...
                else if( output_connections[output_connections.size()-1]
                         != connection_iter )//new connection number
                {
                    output_connections.push_back(connection_iter);
                    gate_j.set_output_connection_number(output_connections);
                    dg_gate[j].set_output_connection_number(output_connections);

                }
                output_connections.clear();

                //assign to input:
                if( gate_i.get_input1_connection_number()!= connection_iter )
                    //&& gate_i.get_input2_connection_number()!=connection_iter ) // new connection number
                {
                    if(!gate_i.get_input1_connection_number()) // not connected to anywhere
                    {
                        gate_i.set_input1_connection_number(connection_iter);
                        dg_gate[i].set_input1_connection_number(connection_iter);
                    }
                    /*
                    else if(!gate_i.get_input2_connection_number())
                    {
                        gate_i.set_input2_connection_number(connection_iter);
                        dg_gate[i].set_input2_connection_number(connection_iter);
                    }
                    */
                }
            }

            //input2:
            if( gate_i.get_gate_input2_x() == gate_j.get_gate_pos_x()
                && gate_i.get_gate_input2_y() == gate_j.get_gate_pos_y() ) //connected
                {
                increase_connection_number = true;
                // assign to output:
                output_connections = gate_j.get_output_connection_number();
                if( output_connections.size()== 0 ) //new connection numer
                {
                    output_connections.push_back(connection_iter);
                    gate_j.set_output_connection_number(output_connections);
                    dg_gate[j].set_output_connection_number(output_connections);
                } // or ...
                else if( output_connections[output_connections.size()-1]
                         != connection_iter )//new connection number
                {
                    output_connections.push_back(connection_iter);
                    gate_j.set_output_connection_number(output_connections);
                    dg_gate[j].set_output_connection_number(output_connections);

                }
                output_connections.clear();

                //assign to input:
                if( // gate_i.get_input1_connection_number()!= connection_iter &&
                        gate_i.get_input2_connection_number()!=connection_iter ) // new connection number
                {
                    /*
                    if(!gate_i.get_input1_connection_number()) // not connected to anywhere
                    {
                        gate_i.set_input1_connection_number(connection_iter);
                        dg_gate[i].set_input1_connection_number(connection_iter);
                    }

                    else*/ if(!gate_i.get_input2_connection_number())
                    {
                               gate_i.set_input2_connection_number(connection_iter);
                               dg_gate[i].set_input2_connection_number(connection_iter);
                           }
                       }
            }
            if(increase_connection_number)
                connection_iter++;
        }
    }
}

void MainWindow::on_actionExit_triggered()
{
    this->close();
}

void MainWindow::on_actionAbout_triggered()
{
    d.show();
}

