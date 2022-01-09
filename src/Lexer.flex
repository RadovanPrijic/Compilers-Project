// import section
import java_cup.runtime.*;

%%

// declaration section
%class Lexer
%cup
%line
%column

%eofval{
	return new Symbol( sym.EOF );
%eofval}

%{
   public int getLine() {
      return yyline;
   }
%}

//states
%state COMMENT

//macros
Slovo = [a-zA-Z]
Cifra = [0-9]
PosebanZnak = [\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\]\\\^\_\`\{\}\~]
BinarniBroj = [0-1]+
OktalniBroj = [0-7]+
DecimalniBroj = 0 | [1-9][0-9]*
HeksadecimalniBroj = [0-9a-fA-F]+
CeliBroj = 2#{BinarniBroj} | 8#{OktalniBroj} | 10#{DecimalniBroj} | 16#{HeksadecimalniBroj} | #{HeksadecimalniBroj} | {DecimalniBroj}
RealanBroj = {Cifra}+\.({Cifra}+)?(E[\+-]?{Cifra}+)?
Znak = '{Slovo}' | '{Cifra}' | '{PosebanZnak}'
Identifikator = {Slovo}({Slovo}|{Cifra})*
Konstanta = {CeliBroj} | {RealanBroj} | {Znak}

%%

// rules section
\/\*\*			{ yybegin( COMMENT );   }
<COMMENT>\*\/	{ yybegin( YYINITIAL ); }
<COMMENT>.		{ ; }

[\t\r\n ]		{ ; }

//operators
"+"			{ return new Symbol( sym.PLUS );       }
"-"         { return new Symbol( sym.SUB );        }
"*"			{ return new Symbol( sym.MUL );        }
"/"         { return new Symbol( sym.DIV );        }

//separators
";"			{ return new Symbol( sym.SEMI );	      }
","			{ return new Symbol( sym.COMMA );	   }
"="			{ return new Symbol( sym.ASSIGN );     }
"("			{ return new Symbol( sym.LEFTPAR );    }
")"			{ return new Symbol( sym.RIGHTPAR );   }
"["			{ return new Symbol( sym.LEFTBOX );    }
"]"			{ return new Symbol( sym.RIGHTBOX );   }
"{"			{ return new Symbol( sym.LEFTBRACE );  }
"}"			{ return new Symbol( sym.RIGHTBRACE ); }

//keywords
"main"	   { return new Symbol( sym.MAIN );	      }	
"int"	      { return new Symbol( sym.INTEGER );	   }
"real"      { return new Symbol( sym.REAL );       } 
"char"	   { return new Symbol( sym.CHAR );	      }
"read"		{ return new Symbol( sym.READ );	      }
"write"		{ return new Symbol( sym.WRITE );	   }
"for"			{ return new Symbol( sym.FOR );	      }
"in"			{ return new Symbol( sym.IN );	      }

//id-s
{Identifikator}	{ return new Symbol( sym.ID );    }
//constants
{Konstanta}			{ return new Symbol( sym.CONST ); }
//error symbol
.		            { System.out.println( "ERROR: " + yytext() ); }

