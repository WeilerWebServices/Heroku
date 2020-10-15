package sample;

import java.io.Serializable;

//TODO: Auto-generated Javadoc
/**
* The Class SampleMessage.
*/
public class SampleMessage implements Serializable {

	private String message;
	
	/**
	 * Instantiates a new sample message.
	 */
	public SampleMessage() {  }
	
	/**
	 * Instantiates a new sample message.
	 *
	 * @param message the message
	 */
	public SampleMessage(String message) {
		super();
		this.message = message;
	}

	/**
	 * Gets the message.
	 *
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * Sets the message.
	 *
	 * @param message the new message
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * To String
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SampleMessage [message=" + message + "]";
	}

}
