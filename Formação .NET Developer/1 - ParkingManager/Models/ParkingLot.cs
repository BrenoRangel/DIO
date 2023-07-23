namespace ParkingManager.Models
{
  public class ParkingLot
  {
    private readonly decimal initialPrice = 0;
    private readonly decimal pricePerHour = 0;
    private readonly List<string> vehicles = new();

    public ParkingLot(decimal initialPrice, decimal pricePerHour)
    {
      this.initialPrice = initialPrice;
      this.pricePerHour = pricePerHour;
    }

    public void RegisterVehicle()
    {
      // TODO: Ask the user to type a license plate (ReadLine) and add it to the "vehicles" list
      // *IMPLEMENT HERE*
      Console.WriteLine("Enter the vehicle plate to park:");
      vehicles.Add(Console.ReadLine());
    }

    public void RemoveVehicle()
    {
      Console.WriteLine("Enter the vehicle plate to remove:");

      // Ask the user to type the plate and store in the plate variable
      // *IMPLEMENT HERE*
      string plate = Console.ReadLine();

      // check if the vehicle exists
      if (vehicles.Any(x => x.ToUpper() == plate.ToUpper()))
      {
        Console.WriteLine("Enter the amount of hours the vehicle remained parked:");

        // All: Ask the user to enter the amount of hours the vehicle remained parked
        // All: perform the following calculation: "initialPrice + pricePerHour * Hours" for the totalValue variable
        // *IMPLEMENT HERE*
        int hours = int.Parse(Console.ReadLine());
        decimal totalValue = initialPrice + pricePerHour * hours;

        // All: Remove the typed plate from the list of vehicles
        // *IMPLEMENT HERE*
        vehicles.RemoveAt(vehicles.IndexOf(plate));

        Console.WriteLine($"The vehicle \"{plate}\" was removed and the total price was: ${totalValue:F2}");
      }
      else
        Console.WriteLine("Sorry, this vehicle is not parked here.Check it out if you typed the plate correctly");
    }

    public void ListVehicles()
    {
      // Check if there are vehicles in the parking lot
      if (!vehicles.Any())
        Console.WriteLine("There are no parked vehicles.");
      else
      {
        Console.WriteLine("Parked vehicles are:");
        // All: perform a repetition bond, displaying the parked vehicles
        // *IMPLEMENT HERE*
        foreach (string vehicle in vehicles) Console.WriteLine(vehicle);
      }
    }
  }
}
