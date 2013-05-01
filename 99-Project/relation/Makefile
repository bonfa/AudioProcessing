FILENAME=elaborato_bonfadelli
SOURCES=./$(FILENAME).tex
BIN=./$(FILENAME).pdf
TEMP_FILES= $(FILENAME).idx $(FILENAME).log $(FILENAME).aux  $(FILENAME).lof  $(FILENAME).out $(FILENAME).toc $(FILENAME).brf $(FILENAME).blg $(FILENAME).bbl 
CC=pdflatex -shell-escape
CC_BIB=bibtex

all: tesi

tesi: 
	$(CC) $(SOURCES)   		\
	&& $(CC_BIB) $(FILENAME) 	\
	&& $(CC) $(SOURCES) 	  	\
	&& $(CC) $(SOURCES) 	  	\
	&& rm $(TEMP_FILES) 		\
	&& evince $(BIN)
	
noView: 
	$(CC) $(SOURCES)   		\
	&& $(CC_BIB) $(FILENAME) 	\
	&& $(CC) $(SOURCES) 	  	\
	&& $(CC) $(SOURCES) 	  	\
	&& rm $(TEMP_FILES)


view:
	evince $(BIN)

clean:
	rm $(TEMP_FILES)

debug:
	$(CC) $(SOURCES)

