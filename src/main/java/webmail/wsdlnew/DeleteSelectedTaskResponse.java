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
 *         &lt;element name="taskdeleted" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="response" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/&gt;
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
    "taskdeleted",
    "response"
})
@XmlRootElement(name = "deleteSelectedTaskResponse", namespace = "http://webmail.com/Task")
public class DeleteSelectedTaskResponse {

    @XmlElement(namespace = "http://webmail.com/Task")
    protected boolean taskdeleted;
    @XmlElement(namespace = "http://webmail.com/Task", required = true)
    protected byte[] response;

    /**
     * Gets the value of the taskdeleted property.
     * 
     */
    public boolean isTaskdeleted() {
        return taskdeleted;
    }

    /**
     * Sets the value of the taskdeleted property.
     * 
     */
    public void setTaskdeleted(boolean value) {
        this.taskdeleted = value;
    }

    /**
     * Gets the value of the response property.
     * 
     * @return
     *     possible object is
     *     byte[]
     */
    public byte[] getResponse() {
        return response;
    }

    /**
     * Sets the value of the response property.
     * 
     * @param value
     *     allowed object is
     *     byte[]
     */
    public void setResponse(byte[] value) {
        this.response = value;
    }

}
