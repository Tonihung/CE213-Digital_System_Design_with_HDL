import sys
from pathlib import Path
import cv2

if len(sys.argv) != 3:
    print("Usage: python convert_to_grayscale.py <input_file> <output_file>")
    sys.exit(1)

python_dir = Path(__file__).resolve().parent
project_dir = python_dir.parent

input_path = project_dir / "input" / sys.argv[1]
output_path = python_dir / "grayscale" / sys.argv[2]

image = cv2.imread(str(input_path))

if image is None:
    print(f"Cannot read: {input_path}")
    sys.exit(1)

gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
gray_image = cv2.resize(gray_image, (256, 256))

output_path.parent.mkdir(parents=True, exist_ok=True)

if not cv2.imwrite(str(output_path), gray_image):
    print(f"Cannot save: {output_path}")
    sys.exit(1)

print(f"Saved: {output_path}")