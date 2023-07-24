using System.Text;
using DesafioProjetoHospedagem.Models;

Console.OutputEncoding = Encoding.UTF8;

// Creates the suite
var suite = new Suite(
    type: "Premium",
    capacity: 3,
    dailyPrice: 30
);

// Creates a new booking, passing the suite and the guests
var booking = new Booking(bookedDays: 12);

booking
    .RegisterSuite(suite)
    // Creates guest models and register on the guest list
    .RegisterGuests(new() {
        new Person(name: "Guest 1"),
        new Person(name: "Guest 2"),
        new Person(name: "Guest 3"),
    }
);

// Shows the amount of guests and the daily price
Console.Clear();
Console.WriteLine($"Booking Manager\n");
Console.WriteLine($"Suite Type: {suite.Type}");
Console.WriteLine($"Capacity: {booking.GetGuestsCount()} of {suite.Capacity}");
Console.WriteLine($"Duration: {booking.BookedDays} {(booking.BookedDays == 1 ? "day" : "days")}");
Console.WriteLine($"Daily Price: $ {suite.DailyPrice:F2}");
Console.WriteLine($"Full Price: $ {booking.CalculateDailyPrice().fullPrice:F2}");
Console.WriteLine($"Final Price: $ {booking.CalculateDailyPrice().finalPrice:F2}\n");