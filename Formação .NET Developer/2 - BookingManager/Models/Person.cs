namespace DesafioProjetoHospedagem.Models;

public class Person
{
  public string FirstName { get; set; }
  public string LastName { get; set; }
  public string FullName => $"{FirstName} {LastName}".ToUpper();
  public Person(string name) => FirstName = name;

  public Person(string name, string lastName)
  {
    FirstName = name;
    LastName = lastName;
  }
}