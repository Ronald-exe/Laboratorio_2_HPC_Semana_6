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


Evento: `cpu/cycles/P`, 4000 Hz — 119K muestras, event count ≈ 103,009,985,620.

### `perf annotate` — `GridIndex::nearest()`

| instrucción | % samples |
|---|---|
| `comisd %xmm0,%xmm1` | 22.80% |
| `jbe 239` | 13.47% |
| `addq $0x4,%rdx` | 7.23% |
| `movsd (%r14),%xmm1` | 3.89% |
| `addsd %xmm1,%xmm0` | 3.54% |
| `subsd 0x8(%rax),%xmm1` | 3.48% |
| `mulsd %xmm1,%xmm1` | 3.47% |
| `subsd (%rax),%xmm0` | 3.42% |
| `mulsd %xmm0,%xmm0` | 3.36% |
| `movslq (%rdx),%rax` | 2.66% |
| `shlq $0x4,%rax` | 2.61% |
| `addq %rdi,%rax` | 2.61% |
| `cmpl -0x34(%rbp),%eax` | 1.73% |
| `cmpl -0x38(%rbp),%ecx` | 2.04% |
| `jne 140` | 1.74% |

---

## Ejercicio D

### Instrumentación con `std::chrono` — regiones medidas

```cpp
auto t0 = std::chrono::steady_clock::now();
/* región medida */
auto t1 = std::chrono::steady_clock::now();
double ms = std::chrono::duration<double, std::milli>(t1 - t0).count();
std::cout << "region_ms=" << ms << "\n";
```

Regiones instrumentadas (8): `generate_target_profile`, `source_deformation`, `build_grid_index`, `profile_metrics` (inicial + por iteración), `nearest_neighbors` (por iteración), `estimate_transform` (por iteración), `export_reconstruction`.

### Corrida individual (`--export`)

141 líneas (1 encabezado + 140 filas): 4 regiones de una sola ejecución + 45 iteraciones × 3 regiones (nearest_neighbors, estimate_transform, profile_metrics) + export_reconstruction.

### Promedio de 5 repeticiones

| región | total_ms | avg_ms | n |
|---|---|---|---|
| `profile_metrics` | 89693.59 | 389.9721 | 230 |
| `nearest_neighbors` | 43757.05 | 194.4758 | 225 |
| `export_reconstruction` | 12104.10 | 2420.8200 | 5 |
| `source_deformation` | 125.03 | 25.0055 | 5 |
| `estimate_transform` | 92.75 | 0.4122 | 225 |
| `generate_target_profile` | 46.17 | 9.2348 | 5 |
| `build_grid_index` | 15.38 | 3.0769 | 5 |

Total acumulado (5 corridas): 145,834.07 ms

### % del tiempo total por región

| región | % |
|---|---|
| `profile_metrics` | 61.50% |
| `nearest_neighbors` | 30.01% |
| `export_reconstruction` | 8.30% |
| `source_deformation` | 0.09% |
| `estimate_transform` | 0.06% |
| `generate_target_profile` | 0.03% |
| `build_grid_index` | 0.01% |

---

## Ejercicio E


### Cambio realizado

Parámetro `sample_fraction` agregado a `compare_profiles()` (default 1.0). Con valor <1.0, muestrea uniformemente (1 de cada N puntos) `target` y `source` antes de las búsquedas de vecino más cercano. Flag `--sample-fraction <valor>` agregado a `main()`.

### Hipótesis

`compare_profiles` construye 2 `GridIndex` adicionales y ejecuta 2 búsquedas completas de vecino más cercano por llamada (46 veces total), trabajo duplicado respecto al loop principal. Reducir la muestra debería reducir el tiempo proporcionalmente sin afectar el resultado final.

### Evidencia: instrumentación manual (Ejercicio D)

| región | avg_ms sin muestreo | avg_ms con `--sample-fraction 0.1` | reducción |
|---|---|---|---|
| `profile_metrics` | ~468 | ~62 | 87% |
| `nearest_neighbors` | ~195 | ~195 | 0% (no tocado) |

### Evidencia: `perf stat`

| métrica | sin muestreo | con `--sample-fraction 0.1` | reducción |
|---|---|---|---|
| task-clock (msec) | 31,420.24 | 15,260.02 | 51.4% |
| elapsed (s) | 31.44 | 15.28 | 51.4% |
| user (s) | 31.16 | 15.24 | 51.1% |
| sys (s) | 0.258 | 0.026 | 90.0% |
| cpu-cycles | 119,922,287,145 | 49,702,712,620 | 58.5% |
| instructions | 206,609,544,410 | 84,798,289,056 | 59.0% |
| branch-misses | 494,710,767 | 195,018,672 | 60.6% |
| page-faults | 97,815 | 5,435 | 94.4% |

### Resultado del algoritmo

| | sin muestreo | con `--sample-fraction 0.1` |
|---|---|---|
| profile_score final | 0.01847086 | 0.01841463 |
| iteraciones | 45 | 45 |
| theta recuperado | -18.00595° | -18.00595° |
| tx, ty recuperados | (-1720.41095, 1781.98006) | (-1720.41095, 1781.98006) |

Diferencia relativa en profile_score: 0.30%.


