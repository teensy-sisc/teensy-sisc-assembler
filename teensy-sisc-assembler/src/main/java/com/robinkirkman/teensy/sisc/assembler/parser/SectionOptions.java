package com.robinkirkman.teensy.sisc.assembler.parser;

public class SectionOptions {
	private boolean relocatable = false;
	private boolean exported = false;
	
	public SectionOptions set(SectionOption opt) {
		switch(opt) {
		case RELOCATABLE:
			relocatable = true;
			break;
		case NON_RELOCATABLE:
			relocatable = false;
			break;
		case EXPORTED:
			exported = true;
			break;
		case NON_EXPORTED:
			exported = false;
			break;
		}
		return this;
	}
	
	public boolean isRelocatable() {
		return relocatable;
	}
	
	public boolean isExported() {
		return exported;
	}
}
