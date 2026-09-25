"""Test tools/sheet2luau.py — jalankan: python3 -m unittest tools/test_sheet2luau.py"""

import copy
import json
import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import sheet2luau  # noqa: E402

EXAMPLE = os.path.join(HERE, "..", "assets", "sheet.example.json")


def load_example():
    with open(EXAMPLE, encoding="utf-8") as f:
        return json.load(f)


class ValidSheet(unittest.TestCase):
    def test_example_generates_two_modules(self):
        with tempfile.TemporaryDirectory() as out:
            result = subprocess.run(
                [sys.executable, os.path.join(HERE, "sheet2luau.py"), EXAMPLE, "--out", out],
                capture_output=True,
                text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            for name in ("AppearanceData.luau", "SpriteData.luau"):
                with open(os.path.join(out, name), encoding="utf-8") as f:
                    text = f.read()
                self.assertTrue(text.startswith("--!strict\n"))
                self.assertIn("return", text)

    def test_output_is_deterministic(self):
        sheet = load_example()
        self.assertEqual(sheet2luau.appearance_luau(sheet, "x"), sheet2luau.appearance_luau(sheet, "x"))
        self.assertEqual(sheet2luau.sprite_luau(sheet, "x"), sheet2luau.sprite_luau(sheet, "x"))


class InvalidSheet(unittest.TestCase):
    def assert_rejected(self, mutate, fragment):
        sheet = load_example()
        mutate(sheet)
        errors = sheet2luau.validate(sheet)
        self.assertTrue(any(fragment in e for e in errors), f"{fragment!r} tidak ada di {errors}")

    def test_example_is_valid(self):
        self.assertEqual(sheet2luau.validate(load_example()), [])

    def test_wrong_portrait_canvas(self):
        self.assert_rejected(lambda s: s["hero"]["canvas"]["portrait"].update(w=200), "192x256")

    def test_wrong_sprite_canvas(self):
        self.assert_rejected(lambda s: s["hero"]["canvas"]["sprite"].update(h=60), "48x64")

    def test_hero_animations_must_cover_12_frames(self):
        self.assert_rejected(lambda s: s["hero"]["animations"].pop(), "12 frame")

    def test_overlapping_animation(self):
        self.assert_rejected(lambda s: s["hero"]["animations"][1].update(first=4), "tumpang")

    def test_anchor_outside_frame(self):
        self.assert_rejected(lambda s: s["hero"]["anchor"].update(y=64), "jangkar")

    def test_unknown_slot(self):
        self.assert_rejected(lambda s: s["hero"]["layers"][0].update(slot="tail"), "slot tidak dikenal")

    def test_duplicate_layer_id(self):
        def dup(s):
            s["hero"]["layers"].append(copy.deepcopy(s["hero"]["layers"][0]))

        self.assert_rejected(dup, "duplikat")

    def test_required_slot_missing_for_rig(self):
        self.assert_rejected(lambda s: s["hero"]["layers"].pop(1), "wajib")

    def test_bad_tint_channel(self):
        self.assert_rejected(lambda s: s["hero"]["slots"][1].update(tint="blue"), "tint")

    def test_bad_palette_color(self):
        self.assert_rejected(lambda s: s["hero"]["palettes"]["skin"].append("#FFF"), "hex")

    def test_bad_rig_id(self):
        self.assert_rejected(lambda s: s["hero"]["rigs"].append("bad rig"), "hero.rigs")

    def test_sprite_bad_category(self):
        self.assert_rejected(lambda s: s["sprites"][0].update(category="monster"), "category")

    def test_sprite_animation_out_of_range(self):
        self.assert_rejected(lambda s: s["sprites"][0]["animations"][1].update(count=5), "di luar")


if __name__ == "__main__":
    unittest.main()
