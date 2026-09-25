#!/usr/bin/env python3
"""sheet.json artist -> Data/AppearanceData.luau & Data/SpriteData.luau.

Format: docs/sheet_format.md. Hanya pustaka standar Python 3.
Pemakaian:
    python3 tools/sheet2luau.py assets/sheet.json --out src/ReplicatedStorage/Data
Keluar dengan kode 1 dan daftar kesalahan bila sheet.json tidak valid.
"""

import argparse
import json
import os
import re
import sys

FORMAT_VERSION = 1
# Angka FINAL (VISUAL_2D §5, RENCANA §3.7): kanvas potret & sprite hero, jumlah frame.
PORTRAIT = (192, 256)
SPRITE = (48, 64)
HERO_FRAMES = 12
TINT_CHANNELS = ("skin", "hair", "primary", "secondary", "accent")
SPRITE_CATEGORIES = ("enemy", "boss", "npc", "building", "vfx")
HEX = re.compile(r"^[0-9A-Fa-f]{6}$")
IDENT = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")


# ---------------------------------------------------------------- validasi


def _is_int(v, minimum=None):
    return isinstance(v, int) and not isinstance(v, bool) and (minimum is None or v >= minimum)


def _check_animations(anims, total, where, errors, exact_cover):
    used = set()
    for a in anims:
        aid = a.get("id")
        if not (isinstance(aid, str) and IDENT.match(aid)):
            errors.append(f"{where}: id animasi tidak valid: {aid!r}")
            continue
        if not (_is_int(a.get("first"), 1) and _is_int(a.get("count"), 1) and _is_int(a.get("fps"), 1)):
            errors.append(f"{where}.{aid}: first/count/fps harus bilangan bulat >= 1")
            continue
        if not isinstance(a.get("loop"), bool):
            errors.append(f"{where}.{aid}: loop harus true/false")
        frames = set(range(a["first"], a["first"] + a["count"]))
        if max(frames) > total:
            errors.append(f"{where}.{aid}: frame {a['first']}..{max(frames)} di luar {total} frame")
        if frames & used:
            errors.append(f"{where}.{aid}: frame tumpang tindih dengan animasi lain")
        used |= frames
    if exact_cover and used != set(range(1, total + 1)):
        errors.append(f"{where}: animasi harus menutup tepat {total} frame (1..{total}), tertutup {len(used)}")


def _check_anchor(anchor, w, h, where, errors):
    if not (isinstance(anchor, dict) and _is_int(anchor.get("x"), 0) and _is_int(anchor.get("y"), 0)):
        errors.append(f"{where}: jangkar {{x, y}} wajib bilangan bulat >= 0")
    elif anchor["x"] >= w or anchor["y"] >= h:
        errors.append(f"{where}: jangkar ({anchor['x']},{anchor['y']}) di luar frame {w}x{h}")


def _check_unique(items, where, errors):
    seen = set()
    for item in items:
        iid = item.get("id")
        if not (isinstance(iid, str) and IDENT.match(iid)):
            errors.append(f"{where}: id tidak valid: {iid!r}")
        elif iid in seen:
            errors.append(f"{where}: id duplikat: {iid}")
        seen.add(iid)


def validate(sheet):
    """Mengembalikan daftar pesan kesalahan (kosong = valid)."""
    errors = []
    if sheet.get("formatVersion") != FORMAT_VERSION:
        errors.append(f"formatVersion harus {FORMAT_VERSION}")
    hero = sheet.get("hero") or {}
    canvas = hero.get("canvas") or {}
    p, s = canvas.get("portrait") or {}, canvas.get("sprite") or {}
    if (p.get("w"), p.get("h")) != PORTRAIT:
        errors.append(f"hero.canvas.portrait harus {PORTRAIT[0]}x{PORTRAIT[1]}")
    if (s.get("w"), s.get("h")) != SPRITE:
        errors.append(f"hero.canvas.sprite harus {SPRITE[0]}x{SPRITE[1]}")
    if s.get("frames") != HERO_FRAMES:
        errors.append(f"hero.canvas.sprite.frames harus {HERO_FRAMES} frame")
    _check_anchor(hero.get("anchor"), SPRITE[0], SPRITE[1], "hero.anchor", errors)
    _check_unique(hero.get("animations") or [], "hero.animations", errors)
    _check_animations(hero.get("animations") or [], HERO_FRAMES, "hero.animations", errors, exact_cover=True)

    rigs = hero.get("rigs") or []
    if not rigs or len(set(rigs)) != len(rigs) or not all(isinstance(r, str) and IDENT.match(r) for r in rigs):
        errors.append("hero.rigs wajib berisi id rig unik (huruf/angka/_)")
    slots = hero.get("slots") or []
    _check_unique(slots, "hero.slots", errors)
    slot_by_id = {sl.get("id"): sl for sl in slots}
    for sl in slots:
        if sl.get("tint") is not None and sl.get("tint") not in TINT_CHANNELS:
            errors.append(f"hero.slots.{sl.get('id')}: tint harus salah satu {TINT_CHANNELS} atau null")
        if not _is_int(sl.get("depth"), 0):
            errors.append(f"hero.slots.{sl.get('id')}: depth wajib bilangan bulat >= 0")
        if not isinstance(sl.get("required"), bool):
            errors.append(f"hero.slots.{sl.get('id')}: required harus true/false")

    layers = hero.get("layers") or []
    _check_unique(layers, "hero.layers", errors)
    covered = set()
    for layer in layers:
        where = f"hero.layers.{layer.get('id')}"
        if layer.get("slot") not in slot_by_id:
            errors.append(f"{where}: slot tidak dikenal: {layer.get('slot')!r}")
            continue
        layer_rigs = layer.get("rigs", rigs)
        if not set(layer_rigs) <= set(rigs) or not layer_rigs:
            errors.append(f"{where}: rigs harus subset tak-kosong dari hero.rigs")
        if "tint" in layer and layer["tint"] is not None and layer["tint"] not in TINT_CHANNELS:
            errors.append(f"{where}: tint harus salah satu {TINT_CHANNELS} atau null")
        for key in ("portrait", "sprite"):
            if not (isinstance(layer.get(key), str) and layer[key].endswith(".png")):
                errors.append(f"{where}: {key} wajib nama berkas .png")
            if not _is_int(layer.get(key + "AssetId"), 0):
                errors.append(f"{where}: {key}AssetId wajib bilangan bulat >= 0 (0 = belum di-upload)")
        for rig in layer_rigs:
            covered.add((layer["slot"], rig))
    for sl in slots:
        if sl.get("required"):
            for rig in rigs:
                if (sl.get("id"), rig) not in covered:
                    errors.append(f"slot wajib '{sl.get('id')}' tidak punya lapisan untuk rig '{rig}'")

    palettes = hero.get("palettes") or {}
    for channel in TINT_CHANNELS:
        colors = palettes.get(channel)
        if not colors:
            errors.append(f"hero.palettes.{channel}: minimal 1 warna")
        elif not all(isinstance(c, str) and HEX.match(c) for c in colors):
            errors.append(f"hero.palettes.{channel}: warna harus hex 6 digit tanpa '#' (RRGGBB)")

    sprites = sheet.get("sprites") or []
    _check_unique(sprites, "sprites", errors)
    for sp in sprites:
        where = f"sprites.{sp.get('id')}"
        if sp.get("category") not in SPRITE_CATEGORIES:
            errors.append(f"{where}: category harus salah satu {SPRITE_CATEGORIES}")
        if not (isinstance(sp.get("file"), str) and sp["file"].endswith(".png")):
            errors.append(f"{where}: file wajib nama berkas .png")
        if not _is_int(sp.get("assetId"), 0):
            errors.append(f"{where}: assetId wajib bilangan bulat >= 0 (0 = belum di-upload)")
        frame = sp.get("frame") or {}
        if not (_is_int(frame.get("w"), 1) and _is_int(frame.get("h"), 1)):
            errors.append(f"{where}: frame {{w, h}} wajib bilangan bulat >= 1")
            continue
        if not (_is_int(sp.get("columns"), 1) and _is_int(sp.get("frames"), 1)):
            errors.append(f"{where}: columns/frames wajib bilangan bulat >= 1")
            continue
        _check_anchor(sp.get("anchor"), frame["w"], frame["h"], f"{where}.anchor", errors)
        _check_unique(sp.get("animations") or [], f"{where}.animations", errors)
        _check_animations(sp.get("animations") or [], sp["frames"], f"{where}.animations", errors, exact_cover=False)
    return errors


# ---------------------------------------------------------------- keluaran Luau


def _lua(value, indent=0):
    pad = "\t" * (indent + 1)
    if value is None:
        return "nil"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return repr(value)
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False)  # literal string JSON = literal string Luau yang valid
    if isinstance(value, list):
        if not value:
            return "{}"
        return "{\n" + "".join(f"{pad}{_lua(v, indent + 1)},\n" for v in value) + "\t" * indent + "}"
    if isinstance(value, dict):
        if not value:
            return "{}"
        lines = []
        for key in sorted(value):
            name = key if IDENT.match(key) else f"[{json.dumps(key)}]"
            lines.append(f"{pad}{name} = {_lua(value[key], indent + 1)},\n")
        return "{\n" + "".join(lines) + "\t" * indent + "}"
    raise TypeError(f"tipe tidak didukung: {type(value)}")


def _anims(anims):
    return {a["id"]: {"first": a["first"], "count": a["count"], "fps": a["fps"], "loop": a["loop"]} for a in anims}


ANIMATION_TYPE = "export type Animation = { first: number, count: number, fps: number, loop: boolean }\n"

APPEARANCE_TYPES = (
    ANIMATION_TYPE
    + "export type Size = { w: number, h: number }\n"
    + "export type Point = { x: number, y: number }\n"
    + "export type Slot = { depth: number, tint: string | false, required: boolean }\n"
    + "export type Layer = {\n"
    + "\tslot: string,\n"
    + "\trigs: { string },\n"
    + "\ttint: string | false,\n"
    + "\tportraitAssetId: number,\n"
    + "\tspriteAssetId: number,\n"
    + "}\n"
    + "export type AppearanceData = {\n"
    + "\tcanvas: { portrait: Size, sprite: { w: number, h: number, frames: number } },\n"
    + "\tanchor: Point,\n"
    + "\tanimations: { [string]: Animation },\n"
    + "\trigs: { string },\n"
    + "\tslots: { [string]: Slot },\n"
    + "\tlayers: { [string]: Layer },\n"
    + "\tpalettes: { [string]: { string } },\n"
    + "}\n"
)

SPRITE_TYPES = (
    ANIMATION_TYPE
    + "export type Sprite = {\n"
    + "\tcategory: string,\n"
    + "\tassetId: number,\n"
    + "\tframe: { w: number, h: number },\n"
    + "\tcolumns: number,\n"
    + "\tframes: number,\n"
    + "\tanchor: { x: number, y: number },\n"
    + "\tanimations: { [string]: Animation },\n"
    + "}\n"
)


def _module(source, what, types, name, type_name, data):
    return (
        _header(source, what)
        + "\n"
        + types
        + f"\nlocal {name}: {type_name} = {_lua(data)}\n\nreturn {name}\n"
    )


def _header(source, what):
    return (
        "--!strict\n"
        f"-- DIHASILKAN oleh tools/sheet2luau.py dari {source} — JANGAN diedit manual.\n"
        f"-- {what} Format: docs/sheet_format.md. assetId 0 = PNG belum di-upload ke grup Roblox.\n"
    )


def appearance_luau(sheet, source):
    hero = sheet["hero"]
    rigs = hero["rigs"]
    slots = {sl["id"]: {"depth": sl["depth"], "tint": sl["tint"] or False, "required": sl["required"]} for sl in hero["slots"]}
    layers = {}
    for layer in hero["layers"]:
        tint = layer["tint"] if "tint" in layer else slots[layer["slot"]]["tint"]
        layers[layer["id"]] = {
            "slot": layer["slot"],
            "rigs": sorted(layer.get("rigs", rigs)),
            "tint": tint or False,
            "portraitAssetId": layer["portraitAssetId"],
            "spriteAssetId": layer["spriteAssetId"],
        }
    data = {
        "canvas": {
            "portrait": {"w": PORTRAIT[0], "h": PORTRAIT[1]},
            "sprite": {"w": SPRITE[0], "h": SPRITE[1], "frames": HERO_FRAMES},
        },
        "anchor": hero["anchor"],
        "animations": _anims(hero["animations"]),
        "rigs": sorted(rigs),
        "slots": slots,
        "layers": layers,
        "palettes": {ch: [c.upper() for c in hero["palettes"][ch]] for ch in TINT_CHANNELS},
    }
    what = "Katalog lapisan hero (potret 192x256 & sprite 48x64 x12 frame per lapisan); tint false = tanpa tint."
    return _module(source, what, APPEARANCE_TYPES, "AppearanceData", "AppearanceData", data)


def sprite_luau(sheet, source):
    data = {}
    for sp in sheet.get("sprites") or []:
        data[sp["id"]] = {
            "category": sp["category"],
            "assetId": sp["assetId"],
            "frame": {"w": sp["frame"]["w"], "h": sp["frame"]["h"]},
            "columns": sp["columns"],
            "frames": sp["frames"],
            "anchor": sp["anchor"],
            "animations": _anims(sp["animations"]),
        }
    what = "Spritesheet musuh/boss/NPC/bangunan/VFX."
    return _module(source, what, SPRITE_TYPES, "SpriteData", "{ [string]: Sprite }", data)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("sheet", help="path sheet.json")
    parser.add_argument("--out", default="src/ReplicatedStorage/Data", help="folder keluaran")
    args = parser.parse_args(argv)
    with open(args.sheet, encoding="utf-8") as f:
        sheet = json.load(f)
    errors = validate(sheet)
    if errors:
        for e in errors:
            print("ERROR:", e, file=sys.stderr)
        return 1
    source = os.path.relpath(args.sheet).replace(os.sep, "/")
    os.makedirs(args.out, exist_ok=True)
    for name, text in (("AppearanceData.luau", appearance_luau(sheet, source)), ("SpriteData.luau", sprite_luau(sheet, source))):
        with open(os.path.join(args.out, name), "w", encoding="utf-8", newline="\n") as f:
            f.write(text)
        print("ditulis:", os.path.join(args.out, name))
    return 0


if __name__ == "__main__":
    sys.exit(main())
