Introduction
============

The Scones web service system (subject concepts or named entities) is used to perform subject concepts and named entities tagging on a target document.

This Scones application is meant to be use in conjunction with the Scones OSF (Open Semantic Framework) web service endpoint. More information can be find here about that endpoint:

1. [Scones web service endpoint documentation](http://wiki.opensemanticframework.org/index.php/Scones "Scones API Documentation")

[OSF Field](http://wiki.opensemanticframework.org/index.php/Using_OSF_Field_Widgets "OSF Field") is a [OSF for Drupal](https://www.drupal.org/project/osf "OSF for Drupal") module that is a user interface that lets people send text documents to the Scones web service endpoint to tag them, review them, and index them within a OSF instance.

Scones uses tomcat6. 

Installing the Scones Web Service Endpoint
==========================================

Installing Scones on a OSF server is easy. You just have to perform the following steps. No that if the setup of your server is different, then you may have to change some paths. First, log into your shell terminal, and then:

    apt-get install tomcat6
	
	cd /var/lib/tomcat6/webapps

	wget https://raw.githubusercontent.com/structureddynamics/Scones/master/scones.war

	mkdir /data/scones/

    cd /data/scones/

	wget https://raw.githubusercontent.com/structureddynamics/Scones/master/models/english-detokenizer.xml
	wget https://raw.githubusercontent.com/structureddynamics/Scones/master/models/en-pos-maxent.bin
	wget https://raw.githubusercontent.com/structureddynamics/Scones/master/models/en-token.bin

	chown -R tomcat6:tomcat6 /data/scones/

	chmod -R 744 /data/scones/

	wget https://raw.githubusercontent.com/structureddynamics/Scones/master/scones.sh

	chmod 755 /etc/init.d/scones.sh


Configuring the Scones Web Service Endpoint
===========================================

Different variables can be configured for operating the Scones web service endpoint. The options should be configured as environment variables. The simplest way to configure the setting options is by modifying the start script `/etc/init.d/scones.sh`.


Here is the list of the configuration options:

- `ONTOLOGY_IRI`: URI of of the ontology. The URI needs to point to the ontology's OWL file. The URI can use the `file://` prefix to refer an ontology file on the local file system. It is what is defined in that ontology that will be used to tag its concepts and named entities
- `PREF_LABEL_PROPERTY`: Property URI that denotes the preferred label of a concept or an entity
- `ALT_LABEL_PROPERTY`: Property URI that denotes the alternative label of a concept or an entity
- `LOG_FOLDER`: Folder where the `ring.log` web service queries log file will be written on the file system
- `TOKENIZER_MODEL`: Location of the tokenizer model file
- `DETOKENIZER_MODEL`: Location of the detokenizer model file
- `POS_TAGGER_MODEL`: Location of the POS tagger model


Running Scones
==============


Starting and restarting Scones is as simple as running the `scones.sh` script:

	/etc/init.d/scones.sh


Querying Scones
===============

Plain tagging without stemming
------------------------------

	 curl -H "Accept: application/json" "http://localhost:8080/scones/tag/concept/plain" -d "Poverty is widespread around the World..."

```javascript
{
    "pref-labels": {
        "poverty": {
            "concepts": [
                "http://purl.org/ontology/peg#Poverty"
            ],
            "indices": [
                [
                    0,
                    6
                ]
            ]
        }
    },
    "alt-labels": null,
    "normalized-text": "poverty is widespread around the world "
}

```

Plain tagging with stemming
------------------------------

	 curl -H "Accept: application/json" "http://localhost:8080/scones/tag/concept/plain/stemming" -d "Poverty is widespread around the World..."

```javascript
{
    "pref-labels": {
        "poverti": {
            "concepts": [
                "http://purl.org/ontology/peg#Poverty"
            ],
            "indices": [
                [
                    0,
                    6
                ]
            ]
        }
    },
    "alt-labels": null,
    "normalized-text": "poverti is widespread around the world"
}

```

Noun tagging without stemming
------------------------------

	 curl -H "Accept: application/json" "http://localhost:8080/scones/tag/concept/plain" -d "Poverty is widespread around the World..."

```javascript
{
    "pref-labels": {
        "poverty": {
            "concepts": [
                "http://purl.org/ontology/peg#Poverty"
            ],
            "indices": [
                [
                    0,
                    6
                ]
            ]
        }
    },
    "alt-labels": null,
    "normalized-text": "poverty is widespread around the world "
}

```

Noun tagging with stemming
------------------------------

	 curl -H "Accept: application/json" "http://localhost:8080/scones/tag/concept/noun/stemming" -d "Poverty is widespread around the World..."

```javascript
{
    "pref-labels": {
        "poverti": {
            "concepts": [
                "http://purl.org/ontology/peg#Poverty"
            ],
            "indices": [
                [
                    1,
                    8
                ]
            ]
        }
    },
    "alt-labels": null,
}

```


Supported Resultset Formats
===========================

The following mimes are supported by the Scones web service endpoint:

- `application/json`
- `application/edn`
- `application/clojure`