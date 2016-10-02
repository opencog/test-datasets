# Human Ontology and Human Gene Annotation Databases

Source (Scheme .scm) data files are available at http://buildbot.opencog.org/downloads/

Neo4j database dumps (xz-compressed) are available at:

1. [go.neo4j.tar.xz](https://drive.google.com/file/d/0B9dx38a6NVxKeE11bmh3ZGpRVFk/view?usp=sharing)
2. [go_annotation.neo4j.tar.xz](https://drive.google.com/file/d/0B9dx38a6NVxKUHN5ZmlTN2Q2YVk/view?usp=sharing)

## Converting Human Ontology Database to Scheme File

1. Download [go.obo](http://www.berkeleybop.org/ontologies/go.obo)
2. Ensure you have Python 2.7
3. With `go.obo` in current directory, run [GO_scm.py](https://github.com/opencog/agi-bio/blob/master/knowledge-import/GO_scm.py)
4. File `GO.scm` will be generated

## Converting Human Gene Annotation Database to Scheme File

1. Download [gene_association.goa_ref_human.gz](http://geneontology.org/gene-associations/gene_association.goa_ref_human.gz)
2. Run `gunzip gene_association.goa_ref_human.gz`
3. Ensure you have Python 2.7
4. With `gene_association.goa_ref_human` in current directory, run [GO_Annotation_scm.py](https://github.com/opencog/agi-bio/blob/master/knowledge-import/GO_Annotation_scm.py)
4. File `GO_annotation.scm` will be generated
