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
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SubsFolderListReturn complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SubsFolderListReturn"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Success" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="SubsFolderListReturn" type="{http://webmail.com/Folder}ArrayOfSubsFolder" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SubsFolderListReturn", namespace = "http://webmail.com/Folder", propOrder = {
    "success",
    "subsFolderListReturn"
})
public class SubsFolderListReturn {

    @XmlElement(name = "Success")
    protected boolean success;
    @XmlElement(name = "SubsFolderListReturn")
    protected ArrayOfSubsFolder subsFolderListReturn;

    /**
     * Gets the value of the success property.
     * 
     */
    public boolean isSuccess() {
        return success;
    }

    /**
     * Sets the value of the success property.
     * 
     */
    public void setSuccess(boolean value) {
        this.success = value;
    }

    /**
     * Gets the value of the subsFolderListReturn property.
     * 
     * @return
     *     possible object is
     *     {@link ArrayOfSubsFolder }
     *     
     */
    public ArrayOfSubsFolder getSubsFolderListReturn() {
        return subsFolderListReturn;
    }

    /**
     * Sets the value of the subsFolderListReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link ArrayOfSubsFolder }
     *     
     */
    public void setSubsFolderListReturn(ArrayOfSubsFolder value) {
        this.subsFolderListReturn = value;
    }

}
