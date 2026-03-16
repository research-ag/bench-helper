module {
  /// Title, description and row and column headers for the benchmark table.
  public type Schema = {
    name : Text;
    description : Text;
    rows : [Text];
    cols : [Text];
  };

  /// Function running the task to measure for row i and column j of the table.
  public type Runner = (Nat, Nat) -> ();

  /// Constructor for the class required by `mops bench`.
  public class V1(schema : Schema, run : (Nat, Nat) -> ()) {
    public func getVersion() : Nat = 1;
    public func getSchema() : Schema = schema;
    public let runCell = run;
  };
};

