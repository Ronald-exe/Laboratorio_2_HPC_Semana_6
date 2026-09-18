## Ejercicio A – Análisis del alineamiento

### 1. ¿Qué representan los centroides de ambos perfiles?

Los centroides representan el punto medio de todos los puntos que forman cada perfil. En este caso hay un centroide para el perfil `target` y otro para el perfil `source`.

Estos sirven como una referencia para ver qué tan separados están los dos perfiles durante el alineamiento.

### 2. ¿Cómo cambia la distancia entre centroides durante las iteraciones?

Tomamos estos valores de algunas iteraciones:

| Iteración | Distancia entre centroides |
|----------:|----------------------------:|
| 1 | 746.03 |
| 10 | 635.73 |
| 20 | 542.56 |
| 21 | 541.59 |
| 30 | 583.81 |
| 45 | 600.87 |

Al principio se nota que los centroides se van acercando. La distancia pasa de 746.03 en la primera iteración hasta 541.59 en la iteración 21. Después vuelve a aumentar un poco y termina en 600.87.

Esto al inicio podría hacernos pensar que el resultado empeoró, pero al revisar las otras métricas no pasa eso. El `chamfer_rmse` baja de 441.65 a 111.00 y la cobertura sube de 80.32 % a 96.94 %.

Entonces, la distancia entre centroides sirve para ver cómo se mueven los perfiles, pero una menor distancia no quiere decir necesariamente que todo el perfil quedó mejor alineado.

### 3. ¿Qué diferencia hay entre `match_rmse`, `symmetric_chamfer_rmse` y `profile_score`?

Las tres métricas sirven para revisar el alineamiento, pero no miden exactamente lo mismo.

| Métrica | Qué estamos midiendo |
|---|---|
| `match_rmse` | El error entre los puntos que fueron tomados como correspondencias durante el alineamiento. |
| `symmetric_chamfer_rmse` | Qué tan separados están los dos perfiles tomando en cuenta las distancias en ambas direcciones. |
| `profile_score` | Una medida general que permite comparar cómo va quedando el perfil durante las iteraciones. |

En nuestros resultados el `profile_score` pasó de 0.04441752 en la primera iteración a 0.01847086 en la última. Como el valor baja, parece que el alineamiento fue mejorando durante la ejecución.

### 4. ¿Por qué una deformación no rígida evita que la transformación recuperada sea exactamente igual a la ideal?

Porque no solamente se movió o rotó el perfil, sino que también cambió un poco su forma con la deformación.

El algoritmo intenta recuperar el alineamiento usando una transformación rígida. Puede corregir la rotación y la traslación, pero no puede deshacer por completo los cambios en la forma del perfil.

Esto se puede ver comparando los valores esperados y recuperados:

| Parámetro | Esperado | Recuperado |
|---|---:|---:|
| Ángulo | -18.00000° | -18.00595° |
| `tx` | -1757.14529 | -1720.41095 |
| `ty` | 2390.34723 | 1781.98006 |

El ángulo quedó bastante cerca del esperado, pero las traslaciones tienen diferencias más grandes. Esto tiene sentido porque el algoritmo busca el mejor ajuste posible para un perfil que ya no tiene exactamente su forma original.


## Ejercicio B – Análisis de rendimiento

### 1. ¿Cuáles funciones aparecen como hotspots en cada herramienta?

Al revisar los resultados de las tres herramientas, `GridIndex::nearest()` aparece como la función donde se concentra la mayor parte del trabajo.

| Herramienta | Hotspot principal | Resultado |
|---|---|---:|
| `perf` | `GridIndex::nearest()` | 98.11 % |
| gperftools | `GridIndex::nearest()` | 94.5 % |
| Valgrind/Callgrind | `GridIndex::nearest()` | 81.10 % |

También aparecen otras funciones como `percentile()`, `compare_profiles()` y algunas operaciones de `vector` y `hashtable`, pero con porcentajes mucho menores.

`GridIndex::nearest()` es el principal cuello de botella. Por eso, si se va a optimizar algo, tendría sentido empezar por esa función.

### 2. ¿Los resultados coinciden entre `perf`, gperftools` y Valgrind?

Sí. Los porcentajes no son iguales, pero las tres herramientas apuntan al mismo lugar.

`perf` reportó 98.11 %, gperftools 94.5 % y Callgrind 81.10 % para el cuerpo de `GridIndex::nearest()`. La diferencia entre estos valores es esperable porque las herramientas no están midiendo exactamente lo mismo.

Lo importante es que las tres coinciden en que `GridIndex::nearest()` domina la ejecución. Así queda más claro que ese es el principal hotspot del programa.

### 3. ¿Qué costo tiene exportar los archivos de reconstrucción?

Se comparó la ejecución normal contra la ejecución utilizando `--export`:

| Métrica | Sin `--export` | Con `--export` |
|---|---:|---:|
| Tiempo total | 55.43 s | 60.71 s |
| Tiempo de usuario | 55.29 s | 60.37 s |
| Tiempo de sistema | 0.13 s | 0.32 s |
| IPC | 2.25 | 2.36 |

El tiempo total aumentó de 55.43 s a 60.71 s, una diferencia de 5.28 s. Es aproximadamente un 9.5 % más.

Entonces sí hay un costo por usar `--export`, pero tampoco es lo que domina el tiempo de ejecución. La exportación tiene que generar varios CSV y también 29 frames PPM con sus archivos, por eso es normal que tarde un poco más.

### 4. ¿Qué herramienta dio la evidencia más clara?

La herramienta que mostró el resultado más claro fue `perf`. En `perf report` se veía que `GridIndex::nearest()` tenía un 98.11 % de las muestras de ciclos, mientras que las demás funciones estaban muy por debajo.

Después, al correr gperftools y Callgrind, salió prácticamente la misma tendencia. Con `perf` alcanzaba para encontrar el problema, y las otras dos herramientas sirvieron para comprobarlo.

## Ejercicio C – Análisis de ensamblador (perf annotate)

### 1. ¿Qué instrucciones concentran más muestras?

| Instrucción | % samples |
|---|---:|
| `comisd %xmm0,%xmm1` | 22.80% |
| `jbe 239` | 13.47% |
| `addq $0x4,%rdx` | 7.23% |
| `movsd (%r14),%xmm1` | 3.89% |
| `addsd %xmm1,%xmm0` | 3.54% |
| `subsd 0x8(%rax),%xmm1` | 3.48% |
| `mulsd %xmm1,%xmm1` | 3.47% |
| `subsd (%rax),%xmm0` | 3.42% |
| `mulsd %xmm0,%xmm0` | 3.36% |

La instrucción que más samples concentra es `comisd` con 22.80%, seguida del salto `jbe` con 13.47%. El resto corresponde a las operaciones de resta, multiplicación y suma que calculan la distancia al cuadrado.

### 2. ¿Esas instrucciones corresponden al hotspot reportado por las herramientas del Ejercicio B?

Sí. Todas pertenecen a `GridIndex::nearest()`, la misma función que aparecía como hotspot en `perf report`, gperftools y Callgrind.

### 3. ¿Qué cambio de código intentaría primero?

Cambiaría la estructura de vecinos. `comisd` y `jbe` juntas representan más de un tercio de las muestras, y ambas están ligadas a la comparación y el control del bucle de búsqueda, no al cálculo de distancia en sí. Una estructura distinta reduciría directamente esas comparaciones.

---

## Ejercicio D – Instrumentación manual

### 1. ¿La región con mayor tiempo coincide con el hotspot de perf, Google Performance Tools y Valgrind?

| Región | % del tiempo total |
|---|---:|
| `profile_metrics` | 61.50% |
| `nearest_neighbors` | 30.01% |

Sí. Entre las dos suman 91.5% del tiempo, y ambas regiones llaman internamente a `GridIndex::nearest()`, coincidiendo con lo visto en el Ejercicio B.

### 2. ¿Cuánto overhead introduce la instrumentación?

No se puede determinar con estos datos, ya que no se corrió una versión del programa sin `std::chrono` para comparar contra el tiempo total.

### 3. ¿Qué partes del programa son más fáciles de entender con instrumentación manual que con muestreo?

Cuántas veces se ejecuta cada región y cuánto pesa en el total. Por ejemplo, `profile_metrics` corrió 230 veces y `nearest_neighbors` 225 veces, y `export_reconstruction` representa 8.30% del tiempo con una sola ejecución por corrida.

### 4. ¿Qué información no puede obtener con instrumentación manual?

El detalle a nivel de instrucción. La instrumentación solo mide la región completa que se definió, pero no qué instrucción puntual dentro de ella consume el tiempo.

## Ejercicio E – Propuesta de optimización

### Cambio realizado

Se agregó el parámetro `sample_fraction` a `compare_profiles()` (default 1.0). Con un valor menor a 1.0, muestrea uniformemente (1 de cada N puntos) tanto el perfil `target` como el `source` antes de las búsquedas de vecino más cercano. Se agregó el flag `--sample-fraction <valor>` a `main()`.

### Hipótesis

`compare_profiles()` construye 2 `GridIndex` adicionales y ejecuta 2 búsquedas completas de vecino más cercano por llamada, 46 veces en total — trabajo duplicado respecto al loop principal de ICP. Reducir la muestra debería bajar el tiempo proporcionalmente sin afectar el resultado final.

### Evidencia — instrumentación manual (Ejercicio D)

| región | avg_ms sin muestreo | avg_ms con --sample-fraction 0.1 | reducción |
|---|---:|---:|---:|
| `profile_metrics` | ~468 | ~62 | 87% |
| `nearest_neighbors` | ~195 | ~195 | 0% (no tocado) |

### Evidencia — perf stat

| métrica | sin muestreo | con --sample-fraction 0.1 | reducción |
|---|---:|---:|---:|
| task-clock (msec) | 31,420.24 | 15,260.02 | 51.4% |
| elapsed (s) | 31.44 | 15.28 | 51.4% |
| user (s) | 31.16 | 15.24 | 51.1% |
| sys (s) | 0.258 | 0.026 | 90.0% |
| cpu-cycles | 119,922,287,145 | 49,702,712,620 | 58.5% |
| instructions | 206,609,544,410 | 84,798,289,056 | 59.0% |
| branch-misses | 494,710,767 | 195,018,672 | 60.6% |
| page-faults | 97,815 | 5,435 | 94.4% |

### Resultado del algoritmo

| | sin muestreo | con --sample-fraction 0.1 |
|---|---:|---:|
| profile_score final | 0.01847086 | 0.01841463 |
| iteraciones | 45 | 45 |
| theta recuperado | -18.00595° | -18.00595° |
| tx, ty recuperados | (-1720.41095, 1781.98006) | (-1720.41095, 1781.98006) |

Diferencia relativa en profile_score: 0.30%.

### Conclusión

La hipótesis fue correcta. `profile_metrics` bajó 87%, y ese ahorro se refleja en el tiempo total (51.4% menos) y en todos los contadores de `perf stat`. `nearest_neighbors` no se tocó y por eso se mantuvo igual, confirmando que el cambio afectó solo la parte esperada. El resultado del algoritmo prácticamente no cambió: mismo número de iteraciones, mismo ángulo y traslación recuperados, y una diferencia de apenas 0.30% en `profile_score`.