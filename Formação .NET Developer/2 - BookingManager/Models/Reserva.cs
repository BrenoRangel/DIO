namespace DesafioProjetoHospedagem.Models
{
  public class Booking
  {
    public List<Person> Guests { get; set; } = new();
    public Suite Suite { get; set; }
    public int BookedDays { get; set; }

    public Booking(int bookedDays) => BookedDays = bookedDays;

    public void RegisterGuests(List<Person> guests)
    {
      // TODO: check that the capacity is greater or equal to the number of guests being received
      // *Implement here *
      if (Suite.Capacity < guests.Count)
        // TODO: return an exception if the capacity is less than the number of guests received
        // *Implement here *
        throw new Exception("Capacity less than the amount of guests received");
      else
        Guests = guests;
    }

    public Booking RegisterSuite(Suite suite)
    {
      Suite = suite;
      return this;
    }

    // TODO: Returns the amount of guests (guest property)
    // *Implement here *
    public int GetGuestsCount() => Guests.Count;

    public (decimal fullPrice, decimal finalPrice) CalculateDailyPrice()
    {
      // TODO: returns the daily rate
      // Cálculo: ReservedDays X Suite.DailyPrice
      // *Implement here *
      decimal fullPrice = BookedDays * Suite.DailyPrice;
      decimal finalPrice = fullPrice;

      // Rule: If the days reserved is greater than or equal to 10, grant a 10% discount
      // *Implement here *
      if (BookedDays >= 10) finalPrice = fullPrice * 0.9m;

      return (fullPrice, finalPrice);
    }
  }
}