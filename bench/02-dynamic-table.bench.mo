import Array "mo:core/Array";
import _Nat "mo:core/Nat";
import Bench "../src";

/// In this example the table rows are generated dynamically.
/// Often, it is useful to generate the row or column headers dynamically.
/// For example, if there are many and they follow a pattern.
/// To do so the schema must be defined inside the init() function.
module {
  let run : Bench.Runner = func(ri, ci) {
    // The code to measure for row ri and column ci
  };

  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "No-op (dynamic table)";
      description = "Table row headers are generated dynamically";
      rows = Array.tabulate(10, func(i) = "Row " # (i).toText());
      cols = ["Col 1", "Col 2"];
    };

    Bench.V1(schema, run);
  };
};
