# Laboratorio 4 — Datos y resultados

## Ejercicio A

### Funciones principales

| Función |
|---|
| `generate_h_rail_cloud()` |
| `add_random_deformation()` |
| `GridIndex::nearest()` |
| `estimate_rigid_transform()` |
| `compare_profiles()` |
| `collimate_icp()` |
| `render_motion_frame()` |
| `export_reconstruction()` |

### Corrida base (`-O2 -g`)

```
Deformación: amplitude=60, rms=56.8088
Transform sintético target→source: theta=18.00000 tx=2409.80239 ty=-1730.36755

Iteraciones: 45
profile_score iter 1:  0.04441752
profile_score iter 45: 0.01847086

Expected source->target:  theta=-18.00000  tx=-1757.14529  ty=2390.34723
Recovered source->target: theta=-18.00595  tx=-1720.41095  ty=1781.98006
```

### Métricas por iteración

| iter | matches | match_rmse | chamfer_rmse | centroid_distance | coverage |
|---|---|---|---|---|---|
| 1 | 81634 | 159.40 | 441.65 | 746.03 | 80.32% |
| 10 | 84859 | 160.12 | 313.57 | 635.73 | 84.18% |
| 20 | 91093 | 158.65 | 222.56 | 542.56 | 92.68% |
| 21 | 92140 | 158.21 | 214.01 | 541.59 | 94.22% |
| 30 | 94642 | 116.60 | 150.16 | 583.81 | 96.04% |
| 45 | 97001 | 62.67 | 111.00 | 600.87 | 96.94% |

### `--export`

- `target_profile.csv`, `source_initial_profile.csv`, `source_final_profile.csv`
- `source_motion.csv`, `profile_metrics.csv`
- 29× `frame_NNN.ppm` + `source_frame_NNN.csv`

---

## Ejercicio B

### `perf stat`

| métrica | sin --export | con --export |
|---|---|---|
| task-clock | 55,410.80 msec | 60,680.42 msec |
| elapsed | 55.43 s | 60.71 s |
| user | 55.29 s | 60.37 s |
| sys | 0.13 s | 0.32 s |
| page-faults | 44,831 | 30,016 |
| cycles (cpu_core) | 93,178,119,903 | 101,882,140,196 |
| instructions (cpu_core) | 209,492,211,552 | 240,637,898,076 |
| IPC (cpu_core) | 2.25 | 2.36 |
| branches (cpu_core) | 27,870,853,503 | 33,975,838,323 |
| branch-misses (cpu_core) | 491,163,817 (1.76%) | 511,117,888 (1.50%) |

### `perf record` / `perf report`

227,407 muestras, 17.5 MB. `cpu_atom/cycles` = 1K muestras, `cpu_core/cycles` = 226K muestras.

`cpu_core/cycles` (self%):

| función | self% |
|---|---|
| `GridIndex::nearest()` | 98.11% |
| `percentile()` | 0.55% |
| `compare_profiles()` | 0.39% |
| `unordered_map::operator[]` | 0.38% |
| `main` | 0.10% |
| `__memmove_avx_unaligned_erms` | 0.10% |
| `nearest_neighbor_distances()` | 0.09% |
| `__sincos_fma` | 0.09% |

### Valgrind Callgrind

207,961,173,979 instrucciones totales (Ir).

| función | Ir | % |
|---|---|---|
| `GridIndex::nearest()` (cuerpo propio) | 168,662,797,252 | 81.10% |
| `GridIndex::nearest()` vía `stl_vector.h` | 20,804,515,668 | 10.00% |
| `GridIndex::nearest()` vía `hashtable.h` | 6,421,932,315 | 3.09% |
| `GridIndex::nearest()` vía `hashtable_policy.h` | 4,139,601,854 | 1.99% |
| `GridIndex::nearest()` vía `stl_algobase.h` | 3,680,330,298 | 1.77% |
| `compare_profiles()` | 662,407,452 | 0.32% |
| `GridIndex::nearest()` vía `stl_function.h` | 617,513,896 | 0.30% |
| `unordered_map::operator[]` | 331,517,688 | 0.16% |
| `main` | 264,667,627 | 0.13% |
| `__sincos_fma` | 245,102,385 | 0.12% |
| `GridIndex::nearest()` vía `stl_iterator.h` | 214,381,544 | 0.10% |

### Google Performance Tools

5610 samples, `point_cloud.prof` (283K).

| función | self | self% | cum% |
|---|---|---|---|
| `GridIndex::nearest` | 5299 | 94.5% | 98.0% |
| `std::vector::operator[]` | 89 | 1.6% | 96.0% |
| `__normal_iterator::__normal_iterator` | 35 | 0.6% | 96.7% |
| `GridIndex::key` | 29 | 0.5% | 97.2% |
| `std::max` | 26 | 0.5% | 97.6% |
| `GridIndex::cell_of` | 24 | 0.4% | 98.1% |
| `std::__unguarded_partition` | 17 | 0.3% | 98.4% |
| `__memcpy_avx_unaligned_erms` | 10 | 0.2% | 98.6% |
| `std::_Hashtable::find` | 9 | 0.2% | 98.7% |

Cumulativos: `collimate_icp` 98.2%, `nearest_neighbor_distances` 65.2%, `compare_profiles` 66.9%, `main` 2.6%.

---

## Ejercicio C (primera mitad — ensamblador/objdump)

`GridIndex::nearest` — líneas 4514–5204 de `point_cloud_collimation.s` (691 líneas).

- `call` dentro de la función: 0
- Saltos condicionales (`j*`): 26
- Instrucciones SIMD (`movups`/`movaps`/`vmov*`): 8
- Acceso indexado con escala (`[reg+reg*8]`): 1
- Direcciones de memoria más frecuentes: `[rsp]`×17, `[rax]`×10, `[r15]`×6, `[r14]`×4, `[rdi]`×3, `[r13]`×2, resto×1

---

## Ejercicio C (segunda mitad — perf annotate)

---

## Ejercicio D

---

## Ejercicio E
