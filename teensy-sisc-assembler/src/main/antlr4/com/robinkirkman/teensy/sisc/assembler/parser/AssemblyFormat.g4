grammar AssemblyFormat;

@header {
import java.util.List;
}

file returns [AssemblerFile afile]:
	namespaces
;

namespaces returns [List<Namespace> nss]:

|	namespaces namespace
;

namespace returns [Namespace ns]:
	'.namespace' name=IDENTIFIER ':' NEWLINE
	namespace_sections
;

namespace_sections returns [List<Section> sections]:

|	namespace_sections namespace_section
;

namespace_section returns [Section section]:
	cs=code_section { $section = $cs.section; }
|	ds=data_section { $section = $ds.section; }
;

code_section returns [CodeSection section]:
	'.code' (name=IDENTIFIER ( section_options )? )? ':' NEWLINE
	code_lines
;

code_lines returns [List<CodeLine> lines]:

|	code_lines NEWLINE
|	code_lines code_line NEWLINE
;

data_section returns [DataSection section]:
	'.data'  (name=IDENTIFIER ( section_options )? )? ':' NEWLINE
	data_lines
;

data_lines returns [List<DataLine> lines]:

|	data_lines NEWLINE
|	data_lines data_line NEWLINE
;

section_options returns [SectionOptions options]:
	section_option { $options = new SectionOptions(); }
|	opts=section_options opt=section_option { $options = $opts.options.set($opt.option); }
;

section_option returns [SectionOption option]:
	'reloc'
|	'noreloc'
|	'export'
|	'noexport'
;

data_line returns [DataLine line]:
	expr
|	data_line ',' expr
;

code_line returns [CodeLine line]:
	'SBN' expr ',' expr ( ',' expr )?
;

expr returns [Expression exp]:
	INTEGER
|	IDENTIFIER
|	'$' '(' expr_body ')'
;

expr_body returns [Expression exp]:
	expr_addsub
;

expr_addsub returns [Expression exp]:
	expr_muldiv
|	expr_addsub ('+' | '-') expr_muldiv
;

expr_muldiv returns [Expression exp]:
	expr_atom
|	expr_muldiv ('*' | '/' | '%') expr_atom	
;

expr_atom returns [Expression exp]:
	INTEGER
|	IDENTIFIER
|	'(' expr_body ')'
;

NEWLINE: ('\r') ? '\n'
;

IDENTIFIER: 
	(('a' .. 'z') | ('A' .. 'Z') | ('0' .. '9') | '_')+
;

INTEGER: (('0' .. '9')+) | ('0' ('x' | 'X') (('0' .. '9') | ('a' .. 'f') | ('A' .. 'F'))+)
;
	
WHITESPACE : ( '\t' | ' ' )+ -> skip
;
