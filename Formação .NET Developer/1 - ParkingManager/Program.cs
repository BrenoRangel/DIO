using ParkingManager.Models;

Console.OutputEncoding = System.Text.Encoding.UTF8;

Console.WriteLine("Welcome to the Parking Manager!\nEnter the starting price:");
decimal initialPrice = Convert.ToDecimal(Console.ReadLine());

Console.WriteLine("Now enter the price per hour:");
decimal pricePerHour = Convert.ToDecimal(Console.ReadLine());

// Instantiates the Parking class, already with the values ​​obtained previously
ParkingLot parkingLot = new(initialPrice, pricePerHour);

bool showMenu = true;

// Starts menu loop
while (showMenu)
{
  Console.Clear();
  Console.WriteLine("1 - Register vehicle");
  Console.WriteLine("2 - Remove vehicle");
  Console.WriteLine("3 - List vehicles");
  Console.WriteLine("4 - Finish");
  Console.WriteLine("\nType your choice:");

  switch (Console.ReadLine())
  {
    case "1":
      parkingLot.RegisterVehicle();
      break;

    case "2":
      parkingLot.RemoveVehicle();
      break;

    case "3":
      parkingLot.ListVehicles();
      break;

    case "4":
      showMenu = false;
      break;

    default:
      Console.WriteLine("Invalid option");
      break;
  }
  Console.WriteLine("Press a key to continue");
  Console.ReadLine();
}
Console.WriteLine("Program finished!");
