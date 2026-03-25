import Array "mo:core/Array";
import Blob "mo:core/Blob";
import Base64 "mo:core/Base64";
import _Nat "mo:core/Nat";
import Bench "../src";

/// In this example, the inputs that are to be processed in each cell
/// measurement are generated dynamically.
/// This can be useful if the inputs are long, follow a pattern, require
/// a prng to generate, etc.
///
/// Note that the column outputs are exactly equal.
module {

  // Generate a Blob of zero bytes of given length
  func zeros(len : Nat) : Blob {
    Array.tabulate<Nat8>(len, func _ = 0)
    |> Blob.fromArray(_);
  };
  // Generate a Blob of mixed bytes of given length
  func mixed(len : Nat) : Blob {
    Array.tabulate<Nat8>(len, func i = (i % 256).toNat8())
    |> Blob.fromArray(_);
  };

  public func init() : Bench.V1 {
    let nRows = 5;

    let schema : Bench.Schema = {
      name = "Base64 zero bytes vs mixed bytes";
      description = "Defined via table of inputs";
      rows = Array.tabulate(nRows, func(i) = (10 ** i).toText());
      cols = ["zero bytes", "mixed bytes"];
    };

    // Pre-generate the inputs as a table so that they can be accessed
    // as `inputs[ri][ci]` during measurement.
    //
    // For accuracy of the measurement it is important to generate input
    // beforehand, not inside the measurement.
    //
    // Moreover, it is important to create the input in table form.
    // This guarantees equal access time for all cells.
    let inputs : [[Blob]] = Array.tabulate(
      nRows,
      func ri = [zeros(10 ** ri), mixed(10 ** ri)],
    );

    let run : Bench.Runner = func(ri, ci) {
      // The code to measure for row ri and column ci
      // For maximum accuracy avoid switch/if statements over ri or ci.
      ignore Base64.encode(inputs[ri][ci]);
    };

    Bench.V1(schema, run);
  };
};
