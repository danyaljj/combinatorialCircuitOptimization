/*! 
Parsing Methods for config files

*/
#include <Parser.h>
#include <string.h>
#include <cctype>
#include <math.h>

using namespace std;

#define DEBUG

/* -------------------------------------------------------------------------- */
/*! This method walks through the string starting at the character where strMsg
 points to and returns the first integer that can be read from this string.
 Any other characters in front of this integer are discarded. After this
 method is returned, strMsg points to the first character after the final
 value of the integer.
 \param strMsg pointer to a character in a string array
 \return first integer that can be read from this string. */
int Parser::parseFirstInt(char** strMsg)
{
	int iRes = 0;
	bool bIsMin = false;
	char *str = *strMsg;

	while (*str != '\0' && !isdigit(*str) && *str != '-')
		str++; // walk to first non digit or minus sign


	if (*str != '\0' && *str == '-') // if it was a minus sign, remember
	{
		bIsMin = true;
		str++;
	}

	while (*str != '\0' && *str <= '9' && *str >= '0') // for all digits
	{
		iRes = iRes * 10 + (int) (*str - '0'); // multiply old res with 10
		str++; // and add new value
	}
	*strMsg = str;
	return (bIsMin) ? -iRes : iRes;
}
/* --------------------------------------------------------------------------------*/
/*! This method walks through the string starting at the character where strMsg
 points to and returns the first double that can be read from this string.
 Any other characters in front of this integer are discarded. After this
 method is returned, strMsg points to the first character after the final
 value of the double. 4e-3, and NaN or nan are also recognized. When input
 contains NaN or nan, -1000.0 is returned.
 \param strMsg pointer to a character in a string array
 \return first double that can be read from this string. */
double Parser::parseFirstDouble(char** strMsg)
{
	double dRes = 0.0, dFrac = 1.0;
	bool bIsMin = false, bInDecimal = false, bCont = true;
	char *str = *strMsg;

	// go to first part of double (digit, minus sign or '.')
	while (*str != '\0' && !isdigit(*str) && *str != '-' && *str != '.')
	{
		// when NaN or nan is double value, return -1000.0
		if ((*str == 'N' && strlen(str) > 3 && *(str + 1) == 'a' && *(str + 2)
				== 'N') || (*str == 'n' && strlen(str) > 3 && *(str + 1) == 'a'
				&& *(str + 2) == 'n'))
		{
			*strMsg = str + 3;
			return -1000.0;
		}
		else
			str++;
	}

	if (*str != '\0' && *str == '-') // if minus sign, remember that
	{
		bIsMin = true;
		str++;
	}

	while (*str != '\0' && bCont) // process the number bit by bit
	{
		if (*str == '.') // in decimal part after '.'
			bInDecimal = true;
		else if (bInDecimal && *str <= '9' && *str >= '0') // number and in decimal
		{
			dFrac = dFrac * 10.0; // shift decimal part to right
			dRes += (double) (*str - '0') / dFrac; // and add number
		}
		else if (*str <= '9' && *str >= '0') // if number and not decimal
			dRes = dRes * 10 + (double) (*str - '0'); // shift left and add number
		else if (*str == 'e') // 10.6e-08           // if to power e
		{
			if (*(str + 1) == '+') // determine sign
				dRes *= pow(10.0, double(parseFirstInt(&str))); // and multiply with power
			else if (*(str + 1) == '-')
			{
				str = str + 2; // skip -
				dRes /= pow(10.0, double(parseFirstInt(&str))); // and divide by power
			}
			bCont = false; // after 'e' stop
		}
		else
			bCont = false; // all other cases stop

		if (bCont == true) // update when not stopped yet
			str++;
	}
	*strMsg = str;
	return (bIsMin && dRes != 0.0) ? -dRes : dRes;
}
/* ---------------------------------------------------------------------------------*/
/*! This method walks through the string starting at the character where strMsg
 points to and stops when or the end of the string is reached or a non space
 is reached. strMsg is updated to this new position.
 \param strMsg pointer to a character in a string array
 \return character that is at the first non space, '\0' when end of string
 is reached. */
char Parser::gotoFirstNonSpace(char** strMsg)
{
	while (*strMsg && isspace(**strMsg))
		(*strMsg)++;
	return (*strMsg) ? **strMsg : '\0';

}
/*------------------------------------------------------------------------------------*/
