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
  /// Pass in the schema and the run function defined by you.
  /// The .bench.mo file needs an `init()` function that returns an instance of this class.
  public class V1(schema : Schema, run : (Nat, Nat) -> ()) {
    /// Used internally by `mops bench`. Not intended to be called by users.
    public func getVersion() : Nat = 1;
    /// Used internally by `mops bench`. Not intended to be called by users.
    public func getSchema() : Schema = schema;
    /// Used internally by `mops bench`. Not intended to be called by users.
    public let runCell = run;
  };
};

