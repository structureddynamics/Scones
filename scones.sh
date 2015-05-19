#!/bin/sh

export JAVA_OPTS="-Xmx1784M" 
export CATALINA_OPTS="-Xmx1784M" 

export LOG_FOLDER="/var/log/tomcat6/"
export TOKENIZER_MODEL="/data/scones/en-token.bin"
export DETOKENIZER_MODEL="/data/scones/english-detokenizer.xml"
export POS_TAGGER_MODEL="/data/scones/en-pos-maxent.bin"
export ONTOLOGY_IRI="file:///data/ontologies/umbel_reference_concepts_linkage.n3"
export PREF_LABEL_PROPERTY="http://purl.org/ontology/iron#prefLabel"
export ALT_LABEL_PROPERTY="http://purl.org/ontology/iron#altLabel"

/etc/init.d/tomcat6 restart
