<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output indent="yes" method="xml"></xsl:output>
    
    <!-- Stefanie Gehrke, 2014-30-05 -->
    <!-- Automatically add facsimile region from a given estimate on a per line basis  -->
    
    <!-- predefined appoximate text surfaces -->
    <xsl:param name="r_x">1950</xsl:param>
    <xsl:param name="v_x">1170</xsl:param>
    <xsl:param name="y">400</xsl:param>
    <xsl:param name="w">3500</xsl:param>
    <xsl:param name="h">6600</xsl:param>
    <xsl:param name="fullW">6050</xsl:param>
    <xsl:param name="fullH">8550</xsl:param>
    
    <xsl:param name="imageBasePath">http://server.where.the.images.are/with/base/identifier</xsl:param>
    
    <xsl:template match="/TEI">
        <TEI>
            <!-- copy everything and add only facs attributes to l and pb elements -->
            <xsl:apply-templates select="@*|node()"/>
            
            <!-- now automatically add facsimile -->
            <xsl:comment>Careful: facsimile autmomatically added and estimated. Please correct if necessary!!!  </xsl:comment>
            <facsimile>
                <!-- build line groups (pages) via the existance of the pb element -->
                <xsl:for-each-group select="/TEI/text/body//lg/l" group-starting-with="/TEI/text/body//lg/l[pb]">
                    <!-- define surface for this page -->
                    <xsl:variable name="pg"><xsl:value-of select="./pb/@n"/></xsl:variable>
                    <xsl:variable name="lx"><xsl:choose>
                        <xsl:when test="contains($pg,'r')"><xsl:value-of select="$r_x"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="$v_x"/></xsl:otherwise>
                    </xsl:choose></xsl:variable>
                    
                    <xsl:element name="surface" >
                        <xsl:attribute name="ulx">0</xsl:attribute>
                        <xsl:attribute name="uly">0</xsl:attribute>
                        <xsl:attribute name="lrx"><xsl:value-of select="$fullW"/></xsl:attribute>
                        <xsl:attribute name="lry"><xsl:value-of select="$fullH"/></xsl:attribute>
                        
                        <!-- base zone refering to the digital facsimile -->
                        <xsl:variable name="id">
                            <xsl:choose>
                                <xsl:when test="@xml:id">
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:when>
                                <!-- if no xml:id use the n attribute -->
                                <xsl:otherwise>
                                    <xsl:value-of select="$pg"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:element name="zone">
                            <xsl:attribute name="ulx">0</xsl:attribute>
                            <xsl:attribute name="uly">0</xsl:attribute>
                            <xsl:attribute name="lrx"><xsl:value-of select="$fullW"/></xsl:attribute>
                            <xsl:attribute name="lry"><xsl:value-of select="$fullH"/></xsl:attribute>
                            <xsl:attribute name="xml:id"><xsl:value-of select="$id"/></xsl:attribute>
                            <xsl:element name="graphic" >
                            <xsl:attribute name="url"><xsl:value-of select="$imageBasePath"/>_<xsl:value-of select="$pg"/>.jpg</xsl:attribute>
                            </xsl:element>
                         </xsl:element>
                        
                    
                    <!-- for each of these groups print the lines -->
                    <xsl:for-each select="current-group()">
                        <xsl:variable name="y1"><xsl:value-of select="$h div last()"/></xsl:variable>
                        <xsl:variable name="y2"><xsl:value-of select="floor($y1)"/></xsl:variable>
                        <xsl:variable name="y3"><xsl:value-of select="$y2 * position()"/></xsl:variable>
                        <xsl:variable name="y4"><xsl:value-of select="$y3+ $y"/></xsl:variable>
                        <xsl:variable name="y5"><xsl:value-of select="floor($y4)"/></xsl:variable>
                        <xsl:variable name="y6"><xsl:value-of select="$y5 - $y2"/></xsl:variable>
                        <xsl:variable name="y7"><xsl:value-of select="$y5 - 1"/></xsl:variable>
                        <xsl:variable name="lr_w"><xsl:value-of select="$lx + $w"/></xsl:variable>
                        <xsl:element name="zone">
                            <xsl:attribute name="ulx"><xsl:value-of select="$lx"/></xsl:attribute>
                            <xsl:attribute name="uly"><xsl:value-of select="$y6"/></xsl:attribute>
                            <xsl:attribute name="lrx"><xsl:value-of select="$lr_w"/></xsl:attribute>
                            <xsl:attribute name="lry"><xsl:value-of select="$y7"/></xsl:attribute>
                            <xsl:attribute name="xml:id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                    </xsl:element>
                </xsl:for-each-group>
                    
            </facsimile>
        </TEI>    
    </xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy copy-namespaces="no">
            <xsl:if test="name()='l' or name()='pb'">
                <xsl:choose>
                    <!-- if xml:id use that -->
                    <xsl:when test="@xml:id">
                        <xsl:attribute name="facs"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"></xsl:value-of></xsl:attribute>
                    </xsl:when>
                    <!-- if no xml:id use the n attribute, especially for pb -->
                    <xsl:when test="@n">
                        <xsl:attribute name="facs"><xsl:text>#</xsl:text><xsl:value-of select="@n"></xsl:value-of></xsl:attribute>
                    </xsl:when>
                    
                </xsl:choose>
               </xsl:if>
            
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>