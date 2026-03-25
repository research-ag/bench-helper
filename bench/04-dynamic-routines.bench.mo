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

  // Generate a Blob of mixed bytes of given length
  func mixedBytes(len : Nat) : Blob {
    Array.tabulate<Nat8>(len, func i = (i % 256).toNat8())
    |> Blob.fromArray(_);
  };

  public func init() : Bench.V1 {
    let nRows = 5;

    let schema : Bench.Schema = {
      name = "Base64 vs no-op";
      description = "Defined via table of routines";
      rows = Array.tabulate(nRows, func i = (10 ** i).toText());
      cols = ["Base64.encode", "no-op function"];
    };

    // Pre-generate the routines to measure as a table.
    // The routines must be of type () -> () and must contain only the code
    // that is to be measured.
    // For example, input generation must happen outside the routine.
    let routines : [[() -> ()]] = Array.tabulate(
      nRows,
      func(ri) {
        // Input generation is outside the routine
        let input = mixedBytes(10 ** ri);
        [
          func() { ignore Base64.encode(input) },
          func() { /* This code is being measured */ },
        ];
      },
    );

    Bench.V1(
      schema,
      func(ri : Nat, ci : Nat) = routines[ri][ci]()
    );
  };
};
