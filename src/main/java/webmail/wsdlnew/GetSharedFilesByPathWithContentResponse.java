//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.11 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.12.31 at 05:59:11 PM IST 
//


package webmail.wsdlnew;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="GetSharedFilesByPath" type="{http://edms.com/documentModule}FileListReturn" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "getSharedFilesByPath"
})
@XmlRootElement(name = "getSharedFilesByPathWithContentResponse")
public class GetSharedFilesByPathWithContentResponse {

    @XmlElement(name = "GetSharedFilesByPath")
    protected FileListReturn getSharedFilesByPath;

    /**
     * Gets the value of the getSharedFilesByPath property.
     * 
     * @return
     *     possible object is
     *     {@link FileListReturn }
     *     
     */
    public FileListReturn getGetSharedFilesByPath() {
        return getSharedFilesByPath;
    }

    /**
     * Sets the value of the getSharedFilesByPath property.
     * 
     * @param value
     *     allowed object is
     *     {@link FileListReturn }
     *     
     */
    public void setGetSharedFilesByPath(FileListReturn value) {
        this.getSharedFilesByPath = value;
    }

}
