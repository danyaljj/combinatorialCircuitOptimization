#ifndef DIGITAL_GATE_H
#define DIGITAL_GATE_H

#include <vector>

class digital_gate
{
public:
    digital_gate();
    digital_gate( int g_pos_x,
                  int g_pos_y,
                  int g_input1_x,
                  int g_input1_y,
                  int g_input2_x,
                  int g_input2_y,
                  int g_type );

    // get methods :
    int get_gate_pos_x();
    int get_gate_pos_y();
    int get_gate_input1_x();
    int get_gate_input1_y();
    int get_gate_input2_x();
    int get_gate_input2_y();
    int get_gate_type();
    //
    int get_input1_connection_number();
    int get_input2_connection_number();
    std::vector<int> get_output_connection_number();

    //set methods:
    void set_gate_pos_x(int a);
    void set_gate_pos_y(int a);
    void set_gate_input1_x(int a);
    void set_gate_input1_y(int a);
    void set_gate_input2_x(int a);
    void set_gate_input2_y(int a);
    void set_gate_type(int a);
    //
    void set_input1_connection_number( int a );
    void set_input2_connection_number( int a );
    void set_output_connection_number( std::vector<int> a );


    /*!
         gate types:
         0:WIRE 1:NOT 2:AND 3:OR 4:NAND 5:NOR 6:XOR 7:XNOR
    */

    int gate_pos_x; // this is because of sort algorithm.
private:
    int gate_pos_y;
    int gate_input1_x;
    int gate_input1_y;
    int gate_input2_x;
    int gate_input2_y;
    int gate_type;

    int input1_connection_number;
    int input2_connection_number;
    std::vector<int> output_connection_number;
};

#endif // DIGITAL_GATE_H
