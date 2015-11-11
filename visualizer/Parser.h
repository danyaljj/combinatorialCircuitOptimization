#include <vector>

#ifndef Parser_H_
#define Parser_H_

using namespace std;

class Parser
{
public:
	Parser(){};
	virtual ~Parser(){};
	int parseFirstInt(char** strMsg); 
	double parseFirstDouble(char** strMsg); 
	char gotoFirstNonSpace(char** strMsg); 
private:

};

#endif /* Parser_H_ */
