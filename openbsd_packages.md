# HDF5 Filter/Compression Libraries — OpenBSD Package Availability

| Directory | Library | OpenBSD Package | Status |
|-----------|---------|-----------------|--------|
| `BLOSC` | Blosc | `blosc-1.21.6p0` | installed |
| `BZIP2` | bzip2 | `bzip2-1.0.8p0` | installed |
| `LZ4` | LZ4 | `lz4-1.10.0` | installed |
| `ZSTD` | Zstandard | `zstd-1.5.7p0` | installed |
| `JPEG` | libjpeg-turbo | `jpeg-3.1.2v0` | installed |
| `SZF` | SZ (libaec) | `libaec-1.1.4` | installed |
| `LZF` | LZF | `liblzf`, `h5py-lzf` (vcpkg) | available as vcpkg |
| `BSHUF` | Bitshuffle | — | not available |
| `ZFP` | ZFP | `zfp` (vcpkg) | available as vcpkg |
| `MAFISC` | MAFISC | — | not available |
| `BITGROOM` | BitGroom | `bitgroomingz` (Spack) | available as Spack |
| `AV`, `CV`, `PV` | internal filters | — | not standalone libs |

## Notes

### SZ Alternative: libaec

`libaec-1.1.4` is available as an OpenBSD port package. libaec (Adaptive Entropy Coding) implements the CCSDS 121.0-B standard and includes Grape (a lossless compression library), making it a suitable alternative to SZ for some use cases.

### Summary

- **Installed:** `blosc`, `bzip2`, `lz4`, `zstd`, `jpeg`, `libaec`
- **Available (not installed):** —
- **Available as vcpkg:** `lzf` (`liblzf`, `h5py-lzf`), `zfp`
- **Available as Spack:** `bitgroom` (`bitgroomingz`)
- **Not available:** `bshuf`, `mafisc`
