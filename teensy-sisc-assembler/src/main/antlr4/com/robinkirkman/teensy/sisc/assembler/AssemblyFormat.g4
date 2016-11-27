grammar AssemblyFormat;

file:
	namespace*
;

namespace:
	'.namespace' name=IDENTIFIER NEWLINE
	namespace_section*
;

namespace_section:
	code_section
|	data_section
;

code_section:
	'.code' (name=IDENTIFIER ( section_options )? )? NEWLINE
;

data_section:
	'.data'  (name=IDENTIFIER ( section_options )? )? NEWLINE
	(data_line NEWLINE)*
;

section_options:
	section_option
|	section_options section_option
;

section_option:
	'reloc' | 'noreloc' | 'export' | 'noexport'
;

data_line:
	expr
|	data_line ',' expr
;

expr:
	INTEGER
;

NEWLINE: ('\r') ? '\n'
;

IDENTIFIER: (('a' .. 'z') | ('A' .. 'Z') | ('0' .. '9') | '_')+
;

INTEGER: (('0' .. '9')+) | ('0' ('x' | 'X') (('0' .. '9') | ('a' .. 'f') | ('A' .. 'F'))+)
;
	
WHITESPACE : ( '\t' | ' ' )+ -> skip
;
