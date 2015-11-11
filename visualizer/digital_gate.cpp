#include "digital_gate.h"

digital_gate::digital_gate()
{
    input1_connection_number = 0;
    input2_connection_number = 0;
    //output_connection_number = 0;
}

digital_gate::digital_gate( int g_pos_x,
              int g_pos_y,
              int g_input1_x,
              int g_input1_y,
              int g_input2_x,
              int g_input2_y,
              int g_type )
{
    gate_pos_x = g_pos_x;
    gate_pos_y = g_pos_y;
    gate_input1_x = g_input1_x;
    gate_input1_y = g_input1_y;
    gate_input2_x = g_input2_x;
    gate_input2_y = g_input2_y;
    gate_type = g_type;
    input1_connection_number = 0;
    input2_connection_number = 0;
    //output_connection_number = 0;
}

int digital_gate::get_gate_pos_x()
{
    return gate_pos_x;
}

int digital_gate::get_gate_pos_y()
{
    return gate_pos_y;
}

int digital_gate::get_gate_input1_x()
{
    return gate_input1_x;
}

int digital_gate::get_gate_input1_y()
{
    return gate_input1_y;
}

int digital_gate::get_gate_input2_x()
{
    return gate_input2_x;
}

int digital_gate::get_gate_input2_y()
{
    return gate_input2_y;
}
int digital_gate::get_gate_type()
{
    return gate_type;
}
int digital_gate::get_input1_connection_number()
{
    return input1_connection_number;
}
int digital_gate::get_input2_connection_number()
{
    return input2_connection_number;
}

std::vector<int> digital_gate::get_output_connection_number()
{
    return output_connection_number;
}

// set methods :
void digital_gate::set_gate_pos_x(int a )
{
    gate_pos_x = a;
}

void digital_gate::set_gate_pos_y(int a)
{
    gate_pos_y = a;
}

void digital_gate::set_gate_input1_x(int a)
{
    gate_input1_x = a;
}

void digital_gate::set_gate_input1_y(int a)
{
    gate_input1_y = a;
}

void digital_gate::set_gate_input2_x(int a)
{
    gate_input2_x = a;
}

void digital_gate::set_gate_input2_y(int a)
{
    gate_input2_y = a;
}
void digital_gate::set_gate_type(int a)
{
    gate_type = a;
}
void digital_gate::set_input1_connection_number(int a)
{
    input1_connection_number = a;
}
void digital_gate::set_input2_connection_number(int a)
{
    input2_connection_number = a;
}
void digital_gate::set_output_connection_number(std::vector<int> a)
{
    output_connection_number = a;
}
