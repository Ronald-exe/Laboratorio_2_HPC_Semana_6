import csv
from collections import defaultdict

sums = defaultdict(float)
counts = defaultdict(int)

for i in range(1, 6):
    with open(f"reconstruction/timing_log_run{i}.csv") as f:
        reader = csv.DictReader(f)
        for row in reader:
            key = row["region"]
            sums[key] += float(row["milliseconds"])
            counts[key] += 1

print(f"{'region':<25}{'total_ms':>15}{'avg_ms':>15}{'n':>8}")
for region in sorted(sums, key=lambda r: -sums[r]):
    total = sums[region]
    avg = total / counts[region]
    print(f"{region:<25}{total:>15.2f}{avg:>15.4f}{counts[region]:>8}")