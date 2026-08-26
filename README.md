# Types and helper class to write benchmark files for use with mops bench

## Usage

Example benchmark file (taken from the `prng` package):

```motoko
import Bench "mo:bench-helper";
import Prng "mo:prng";

module {
  public func init() : Bench.V1 {
    let schema : Bench.Schema = {
      name = "Prng";
      description = "Benchmark N `next` calls for different PRNGs";
      rows = ["Seiran128", "SFC64", "SFC32"];
      cols = ["10", "100", "1000", "10000"];
    };

    let rngs : [{ next : () -> Any }] = [
      Prng.Seiran128(),
      Prng.SFC64a(),
      Prng.SFC32a(),
    ];

    let ns : [Nat16] = [10, 100, 1000, 10000];

    let run : Bench.Runner = func(ri, ci) {
      let n = ns[ci];
      let next = rngs[ri].next;
      var i : Nat16 = 0;
      while (i < n) {
        ignore next();
        i +%= 1;
      };
    };

    Bench.V1(schema, run);
  };
};

```

The `bench-helper` package defines the type `Schema`, `Runner`, and the constructor `V1`.

A systematic set of examples can be found in the `bench/` directory.

## Development

### Formatting

To format the code, run:

```bash
npx -y prettier --plugin prettier-plugin-motoko --write '**/*.{mo,json,md}'
```

## License

This project is licensed under the MIT License.
