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
 *         &lt;element name="GetSubFolder" type="{http://webmail.com/Folder}MailFolderListReturn" minOccurs="0"/&gt;
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
    "getSubFolder"
})
@XmlRootElement(name = "getWebmailFolderOtherResponse", namespace = "http://webmail.com/Folder")
public class GetWebmailFolderOtherResponse {

    @XmlElement(name = "GetSubFolder", namespace = "http://webmail.com/Folder")
    protected MailFolderListReturn getSubFolder;

    /**
     * Gets the value of the getSubFolder property.
     * 
     * @return
     *     possible object is
     *     {@link MailFolderListReturn }
     *     
     */
    public MailFolderListReturn getGetSubFolder() {
        return getSubFolder;
    }

    /**
     * Sets the value of the getSubFolder property.
     * 
     * @param value
     *     allowed object is
     *     {@link MailFolderListReturn }
     *     
     */
    public void setGetSubFolder(MailFolderListReturn value) {
        this.getSubFolder = value;
    }

}
