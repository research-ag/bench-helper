import Bench "../src";

/// In this example, the table rows and columns and the function
/// to run each cell are static. In this case they can be defined
/// at module level.
module {
  let schema : Bench.Schema = {
    name = "No-op (static table)";
    description = "Table headers are statically defined";
    rows = ["Row 1", "Row 2"];
    cols = ["Col 1", "Col 2"];
  };

  let run : Bench.Runner = func(ri, ci) {
    // The code to measure for row ri and column ci
  };

  public func init() : Bench.V1 = Bench.V1(schema, run);
};
