//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.11 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.12.31 at 05:59:11 PM IST 
//


package webmail.wsdlnew;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for imapquota complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="imapquota"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="quotalimit" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *         &lt;element name="quotauses" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "imapquota", namespace = "http://webmail.com/Imapquota", propOrder = {
    "quotalimit",
    "quotauses"
})
public class Imapquota {

    protected long quotalimit;
    protected long quotauses;

    /**
     * Gets the value of the quotalimit property.
     * 
     */
    public long getQuotalimit() {
        return quotalimit;
    }

    /**
     * Sets the value of the quotalimit property.
     * 
     */
    public void setQuotalimit(long value) {
        this.quotalimit = value;
    }

    /**
     * Gets the value of the quotauses property.
     * 
     */
    public long getQuotauses() {
        return quotauses;
    }

    /**
     * Sets the value of the quotauses property.
     * 
     */
    public void setQuotauses(long value) {
        this.quotauses = value;
    }

}
