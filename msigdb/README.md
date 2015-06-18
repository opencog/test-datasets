# Molecular Signature Database (MSigDB)

Download from [MSigDB database](http://www.broadinstitute.org/gsea/downloads.jsp#msigdb)

Both [msigdb_v5.0.xml](http://www.broadinstitute.org/gsea/msigdb/download_file.jsp?filePath=/resources/msigdb/5.0/msigdb_v5.0.xml)
and [msigdb_v4.0.xml](http://www.broadinstitute.org/gsea/msigdb/download_file.jsp?filePath=/resources/msigdb/4.0/msigdb_v4.0.xml) are supported.

OpenCog data files are available at http://buildbot.opencog.org/downloads/

## How to Convert to Scheme File

1. Download [msigdb_v5.0.xml](http://www.broadinstitute.org/gsea/msigdb/download_file.jsp?filePath=/resources/msigdb/5.0/msigdb_v5.0.xml)
2. Ensure you have Python 2.7
3. With `msigdb_v5.0.xml` in current directory, run [MSigDB_to_scheme.py](https://github.com/opencog/agi-bio/blob/master/knowledge-import/MSigDB_to_scheme.py)
4. When prompted with "Press D to generate scheme file with description or press Enter.":
    * press `D` to generate `msigdb_v5.0_verbose.scm`
    * press `Enter` to generate `msigdb_v5.0.scm`
