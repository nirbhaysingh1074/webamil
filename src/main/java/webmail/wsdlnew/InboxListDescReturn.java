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
 * <p>Java class for InboxListDescReturn complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="InboxListDescReturn"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="SuccessDesc" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="InboxListDescReturn" type="{http://webmail.com/Inbox}ArrayOfInboxMailDesc" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "InboxListDescReturn", namespace = "http://webmail.com/Inbox", propOrder = {
    "successDesc",
    "inboxListDescReturn"
})
public class InboxListDescReturn {

    @XmlElement(name = "SuccessDesc")
    protected boolean successDesc;
    @XmlElement(name = "InboxListDescReturn")
    protected ArrayOfInboxMailDesc inboxListDescReturn;

    /**
     * Gets the value of the successDesc property.
     * 
     */
    public boolean isSuccessDesc() {
        return successDesc;
    }

    /**
     * Sets the value of the successDesc property.
     * 
     */
    public void setSuccessDesc(boolean value) {
        this.successDesc = value;
    }

    /**
     * Gets the value of the inboxListDescReturn property.
     * 
     * @return
     *     possible object is
     *     {@link ArrayOfInboxMailDesc }
     *     
     */
    public ArrayOfInboxMailDesc getInboxListDescReturn() {
        return inboxListDescReturn;
    }

    /**
     * Sets the value of the inboxListDescReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link ArrayOfInboxMailDesc }
     *     
     */
    public void setInboxListDescReturn(ArrayOfInboxMailDesc value) {
        this.inboxListDescReturn = value;
    }

}
