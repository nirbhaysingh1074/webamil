//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.11 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.12.31 at 05:59:11 PM IST 
//


package webmail.wsdlnew;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for DisplayContact complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DisplayContact"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="webamilVCFFileName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilNote" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilFullName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilCompany" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilJob" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilEmail" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilWebPage" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilPhoneWork" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilPhoneHome" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilPhoneFax" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilPhoneMob" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webmailAddrWork" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilAddrHome" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilPre" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilSuf" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webmailMNM" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilFNM" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilLNM" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilPhoto" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="webamilPhotoByte" type="{http://www.w3.org/2001/XMLSchema}byte" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DisplayContact", namespace = "http://webmail.com/CreateContact", propOrder = {
    "webamilVCFFileName",
    "webamilNote",
    "webamilFullName",
    "webamilCompany",
    "webamilJob",
    "webamilEmail",
    "webamilWebPage",
    "webamilPhoneWork",
    "webamilPhoneHome",
    "webamilPhoneFax",
    "webamilPhoneMob",
    "webmailAddrWork",
    "webamilAddrHome",
    "webamilPre",
    "webamilSuf",
    "webmailMNM",
    "webamilFNM",
    "webamilLNM",
    "webamilPhoto",
    "webamilPhotoByte"
})
public class DisplayContact {

    @XmlElement(required = true)
    protected String webamilVCFFileName;
    @XmlElement(required = true)
    protected String webamilNote;
    @XmlElement(required = true)
    protected String webamilFullName;
    @XmlElement(required = true)
    protected String webamilCompany;
    @XmlElement(required = true)
    protected String webamilJob;
    @XmlElement(required = true)
    protected String webamilEmail;
    @XmlElement(required = true)
    protected String webamilWebPage;
    @XmlElement(required = true)
    protected String webamilPhoneWork;
    @XmlElement(required = true)
    protected String webamilPhoneHome;
    @XmlElement(required = true)
    protected String webamilPhoneFax;
    @XmlElement(required = true)
    protected String webamilPhoneMob;
    @XmlElement(required = true)
    protected String webmailAddrWork;
    @XmlElement(required = true)
    protected String webamilAddrHome;
    @XmlElement(required = true)
    protected String webamilPre;
    @XmlElement(required = true)
    protected String webamilSuf;
    @XmlElement(required = true)
    protected String webmailMNM;
    @XmlElement(required = true)
    protected String webamilFNM;
    @XmlElement(required = true)
    protected String webamilLNM;
    @XmlElement(required = true)
    protected String webamilPhoto;
    @XmlElement(type = Byte.class)
    protected List<Byte> webamilPhotoByte;

    /**
     * Gets the value of the webamilVCFFileName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilVCFFileName() {
        return webamilVCFFileName;
    }

    /**
     * Sets the value of the webamilVCFFileName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilVCFFileName(String value) {
        this.webamilVCFFileName = value;
    }

    /**
     * Gets the value of the webamilNote property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilNote() {
        return webamilNote;
    }

    /**
     * Sets the value of the webamilNote property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilNote(String value) {
        this.webamilNote = value;
    }

    /**
     * Gets the value of the webamilFullName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilFullName() {
        return webamilFullName;
    }

    /**
     * Sets the value of the webamilFullName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilFullName(String value) {
        this.webamilFullName = value;
    }

    /**
     * Gets the value of the webamilCompany property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilCompany() {
        return webamilCompany;
    }

    /**
     * Sets the value of the webamilCompany property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilCompany(String value) {
        this.webamilCompany = value;
    }

    /**
     * Gets the value of the webamilJob property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilJob() {
        return webamilJob;
    }

    /**
     * Sets the value of the webamilJob property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilJob(String value) {
        this.webamilJob = value;
    }

    /**
     * Gets the value of the webamilEmail property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilEmail() {
        return webamilEmail;
    }

    /**
     * Sets the value of the webamilEmail property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilEmail(String value) {
        this.webamilEmail = value;
    }

    /**
     * Gets the value of the webamilWebPage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilWebPage() {
        return webamilWebPage;
    }

    /**
     * Sets the value of the webamilWebPage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilWebPage(String value) {
        this.webamilWebPage = value;
    }

    /**
     * Gets the value of the webamilPhoneWork property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilPhoneWork() {
        return webamilPhoneWork;
    }

    /**
     * Sets the value of the webamilPhoneWork property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilPhoneWork(String value) {
        this.webamilPhoneWork = value;
    }

    /**
     * Gets the value of the webamilPhoneHome property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilPhoneHome() {
        return webamilPhoneHome;
    }

    /**
     * Sets the value of the webamilPhoneHome property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilPhoneHome(String value) {
        this.webamilPhoneHome = value;
    }

    /**
     * Gets the value of the webamilPhoneFax property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilPhoneFax() {
        return webamilPhoneFax;
    }

    /**
     * Sets the value of the webamilPhoneFax property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilPhoneFax(String value) {
        this.webamilPhoneFax = value;
    }

    /**
     * Gets the value of the webamilPhoneMob property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilPhoneMob() {
        return webamilPhoneMob;
    }

    /**
     * Sets the value of the webamilPhoneMob property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilPhoneMob(String value) {
        this.webamilPhoneMob = value;
    }

    /**
     * Gets the value of the webmailAddrWork property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebmailAddrWork() {
        return webmailAddrWork;
    }

    /**
     * Sets the value of the webmailAddrWork property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebmailAddrWork(String value) {
        this.webmailAddrWork = value;
    }

    /**
     * Gets the value of the webamilAddrHome property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilAddrHome() {
        return webamilAddrHome;
    }

    /**
     * Sets the value of the webamilAddrHome property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilAddrHome(String value) {
        this.webamilAddrHome = value;
    }

    /**
     * Gets the value of the webamilPre property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilPre() {
        return webamilPre;
    }

    /**
     * Sets the value of the webamilPre property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilPre(String value) {
        this.webamilPre = value;
    }

    /**
     * Gets the value of the webamilSuf property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilSuf() {
        return webamilSuf;
    }

    /**
     * Sets the value of the webamilSuf property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilSuf(String value) {
        this.webamilSuf = value;
    }

    /**
     * Gets the value of the webmailMNM property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebmailMNM() {
        return webmailMNM;
    }

    /**
     * Sets the value of the webmailMNM property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebmailMNM(String value) {
        this.webmailMNM = value;
    }

    /**
     * Gets the value of the webamilFNM property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilFNM() {
        return webamilFNM;
    }

    /**
     * Sets the value of the webamilFNM property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilFNM(String value) {
        this.webamilFNM = value;
    }

    /**
     * Gets the value of the webamilLNM property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilLNM() {
        return webamilLNM;
    }

    /**
     * Sets the value of the webamilLNM property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilLNM(String value) {
        this.webamilLNM = value;
    }

    /**
     * Gets the value of the webamilPhoto property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getWebamilPhoto() {
        return webamilPhoto;
    }

    /**
     * Sets the value of the webamilPhoto property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setWebamilPhoto(String value) {
        this.webamilPhoto = value;
    }

    /**
     * Gets the value of the webamilPhotoByte property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the webamilPhotoByte property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getWebamilPhotoByte().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Byte }
     * 
     * 
     */
    public List<Byte> getWebamilPhotoByte() {
        if (webamilPhotoByte == null) {
            webamilPhotoByte = new ArrayList<Byte>();
        }
        return this.webamilPhotoByte;
    }

}
