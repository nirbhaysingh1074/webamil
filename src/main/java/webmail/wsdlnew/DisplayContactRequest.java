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
 *         &lt;element name="getVFCIOStream" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="getVFCFileName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
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
    "getVFCIOStream",
    "getVFCFileName"
})
@XmlRootElement(name = "displayContactRequest", namespace = "http://webmail.com/CreateContact")
public class DisplayContactRequest {

    @XmlElement(namespace = "http://webmail.com/CreateContact", required = true)
    protected String getVFCIOStream;
    @XmlElement(namespace = "http://webmail.com/CreateContact", required = true)
    protected String getVFCFileName;

    /**
     * Gets the value of the getVFCIOStream property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGetVFCIOStream() {
        return getVFCIOStream;
    }

    /**
     * Sets the value of the getVFCIOStream property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGetVFCIOStream(String value) {
        this.getVFCIOStream = value;
    }

    /**
     * Gets the value of the getVFCFileName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGetVFCFileName() {
        return getVFCFileName;
    }

    /**
     * Sets the value of the getVFCFileName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGetVFCFileName(String value) {
        this.getVFCFileName = value;
    }

}
