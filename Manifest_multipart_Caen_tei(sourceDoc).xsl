<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"     xmlns:tei="http://www.tei-c.org/ns/1.0">
    <!-- XSL transformation for the TEI transcript metadata to minimal Shared Canvans -->
    <!-- Original version, Stefanie Gehrke, Biblissima , 2014      -->
    
    <!-- Change Log -->
    <!-- Stefanie Gehrke, 2014-01-07 : Created -->
    <!-- Stefanie Gehrke, 2014-01.09 : URIs for transscript missing!! -->
    
    <!-- <xsl:output method="text" encoding="UTF-8" indent="yes"/>  -->  
    <!-- for many output files replace xsl:output by xsl:result-document 
                   with the name of the document -->
                   <!-- problems - xsl result-document can’t append/reopen an output file, i.e. each document has to be written at once -->
    <!-- 2.problem for the 3 input files a common numbering 1-x is more complicated -->
        <!-- so first output a simple manifest -->
        <!-- then the annotation list , or include that in the manifest? I need something like http://www.shared-canvas.org/impl/demo1d/res/list/text-f1r.json but without specificResource for each canvas (=179 x 2 folios) not a basic manifest, only the annotation lists with “header” -->
        
    <!-- directly from sourceDoc -->
    
    <xsl:template match="/">
        
        
        
        <!-- Naming by Folio - first use of  $pg as  ID of the list  =list per canvas. -->
        
        <!-- simple xml file as a start containing all the paths of the multifile data -->
        
        
        <xsl:for-each select="//file">
            <xsl:variable name="fileName"><xsl:value-of select="."/></xsl:variable>
            <!-- Only for Edition of A ; don't use for edition of B ! -->
            
            <xsl:if test="position()!=1"> ,</xsl:if>
            <!-- loop over all pages -->
            <xsl:for-each-group select="document($fileName)/TEI/sourceDoc//line" group-starting-with="/TEI/sourceDoc//line[pb]">
                <!-- set "," between subsequent canvases -->
                <xsl:if test="position()!=1"> ,</xsl:if>
 
                
                <!-- here JSON-File per Annotationlist per Canvas with inserted Resources = Lines -->
                
                <xsl:variable name="pagebreakNumber"><xsl:value-of select="./pb/@n"/></xsl:variable><!-- Numbering Canvas (folio) -->
                <xsl:variable name="outputFile">BL_Add_10289_transscript_<xsl:value-of select="$pagebreakNumber"/>.json</xsl:variable>
                <xsl:if test=".//pb[@ed='A']">
                <xsl:result-document href="{$outputFile}" method="text" encoding="UTF-8" indent="yes">
                    {
                    "@context": "http://www.shared-canvas.org/ns/context.json",
                    "@id": "http://demos.biblissima-condorcet.fr/iiif/metadata/BL_Add_10289/list/transscript_<xsl:value-of select="$pagebreakNumber"/>.json",
                    "@type": "sc:AnnotationList",
                    "resources":[    
                    
                    <!-- for eachof these groups print the lines -->
                    <xsl:for-each select="current-group()"><!-- nur XSL 2.0 -->
                        <xsl:if test="position()!=1"> ,</xsl:if>    
                        {
                        <xsl:variable name="line"><xsl:value-of select="./@n"/></xsl:variable>
                        "@id":"http://demos.biblissima-condorcet.fr/iiif/metadata/BL_Add_10289/Annotation/<xsl:value-of select="$pagebreakNumber"/>_line<xsl:value-of select="$line"/>.json",
                        "@type":"oa:Annotation",
                        "motivation":"sc:painting",
                        "resource":{
                        "@type":"cnt:ContentAsText",
                        <xsl:variable name="lineText"><xsl:value-of select="text()"/></xsl:variable>
                        "chars":"<xsl:value-of select="normalize-space($lineText)"></xsl:value-of>", <!-- exclude of notes, emph, ... -->
                        "format":"text/plain",
                        "language":"<xsl:value-of select="//profileDesc/langUsage/language/@ident"/>"
                        },
                        <!-- calculate position, only two arguments to each operation!! alternaticve numeric-... functions-->
                        <!-- upper left x  -->
                        <xsl:variable name="x"><xsl:value-of select="../@ulx"/></xsl:variable>
                        <!-- upper left y  -->
                        <xsl:variable name="y"><xsl:value-of select="../@uly"/></xsl:variable> 
                        <!-- width = lower right x  -  upper left x  -->
                        <xsl:variable name="w"><xsl:value-of select="../@lrx - ../@ulx"/></xsl:variable>
                        <!-- height = lower right y  -  upper left y  -->
                        <xsl:variable name="h"><xsl:value-of select="../@lry - ../@uly"/></xsl:variable> 
                        <xsl:text>"on":"http://sanddragon.bl.uk/IIIFMetadataService/canvas/folio-</xsl:text><xsl:value-of select="$pagebreakNumber"/><xsl:text>.json#xywh=</xsl:text><xsl:value-of select="($x)"/><xsl:text>,</xsl:text><xsl:value-of select="($y)"/><xsl:text>,</xsl:text><xsl:value-of select="($w)"/><xsl:text>,</xsl:text><xsl:value-of select="($h)"/><xsl:text>"</xsl:text>
                        
                        }
                    </xsl:for-each>
                    ]
                    }
                </xsl:result-document>
                </xsl:if>
                ]
                }
            </xsl:for-each-group>
        </xsl:for-each>        ]
        }
    </xsl:template>
</xsl:stylesheet>