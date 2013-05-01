FILENAME=thesis
SOURCES=./$(FILENAME).tex
BIN=./$(FILENAME).pdf
TEMP_FILES= thesis.idx thesis.log thesis.aux  thesis.lof  thesis.out thesis.toc thesis.brf thesis.blg thesis.bbl 
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

