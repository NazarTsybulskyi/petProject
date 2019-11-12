public class JSON2Apex {

	public String productId;
	public Boolean coFinanceSelected;
	
	public static List<JSON2Apex> parse(String jsonString) {
		return (List<JSON2Apex>) System.JSON.deserialize(jsonString, List<JSON2Apex>.class);
	}
}