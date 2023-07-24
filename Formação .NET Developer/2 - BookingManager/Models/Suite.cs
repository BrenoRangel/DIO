namespace DesafioProjetoHospedagem.Models
{
  public class Suite
  {
    public string Type { get; set; }
    public int Capacity { get; set; }
    public decimal DailyPrice { get; set; }

    public Suite(string type, int capacity, decimal dailyPrice)
    {
      Type = type;
      Capacity = capacity;
      DailyPrice = dailyPrice;
    }
  }
}