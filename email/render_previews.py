#!/usr/bin/env python3
"""Render the Buttondown email source (003-agentic-ai-with-jac.md) into the two
browser-preview HTML files. Run after editing the .md so previews stay in sync.

    python3 email/render_previews.py
"""
import re, sys, pathlib

HERE = pathlib.Path(__file__).parent
SRC = HERE / "003-agentic-ai-with-jac.md"

FONT_IMPORT = "@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');"
INTER = ("@font-face{font-family:'Inter';font-style:normal;font-weight:100 900;font-display:swap;"
         "src:url('https://rsms.me/inter/font-files/InterVariable.woff2?v=4.0') format('woff2');}")

# ---- inline markdown: **bold**, [text](url), `code` ----
def inline(s, fmt):
    s = re.sub(r"`([^`]+)`", lambda m: '<code style="background:#f0ece3;padding:1px 5px;border-radius:4px;font-size:0.9em;font-family:\'SFMono-Regular\',Consolas,monospace;">%s</code>' % m.group(1), s)
    s = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", s)
    if fmt == "email":
        s = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<a href="\2" style="color:#c0531f;text-decoration:underline;">\1</a>', s)
    else:
        s = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<a href="\2">\1</a>', s)
    return s

def h2(text, fmt):
    if fmt == "email":
        return ('<h2 style="font-family:\'Inter\',\'Helvetica Neue\',Arial,sans-serif;font-size:22px;font-weight:700;'
                'text-transform:uppercase;letter-spacing:-0.01em;color:#160f0a;margin:34px 24px 10px;padding-top:18px;">%s</h2>' % text)
    return "<h2>%s</h2>" % text

def h3(text, fmt):
    m = re.match(r"\[([^\]]+)\]\(([^)]+)\)", text)
    label, url = (m.group(1), m.group(2)) if m else (text, "#")
    if fmt == "email":
        return ('<h3 style="font-family:\'Inter\',\'Helvetica Neue\',Arial,sans-serif;font-size:17px;font-weight:700;'
                'line-height:1.3;color:#160f0a;margin:20px 24px 6px;"><a href="%s" style="color:#160f0a;text-decoration:none;">%s</a></h3>' % (url, label))
    return '<h3><a href="%s">%s</a></h3>' % (url, label)

def para(text, fmt):
    if fmt == "email":
        return ('<p style="font-family:\'Inter\',\'Helvetica Neue\',Arial,sans-serif;font-size:15px;line-height:1.6;'
                'color:#1f160e;margin:14px 24px;">%s</p>' % inline(text, fmt))
    return "<p>%s</p>" % inline(text, fmt)

def render_body(md, fmt):
    # drop the leading font <style> line (it lives in <head>)
    md = re.sub(r"^\s*<style>@import[^\n]*</style>\s*", "", md, count=1)
    lines = md.split("\n")
    out, i, n = [], 0, len(lines)
    while i < n:
        line = lines[i]
        s = line.rstrip("\n")
        if s.strip() == "":
            i += 1; continue
        if s[0] == "<":  # raw HTML block at column 0
            m = re.match(r"<(\w+)", s)
            tag = m.group(1) if m else ""
            block = [s]
            single = ("</%s>" % tag) in s or s.rstrip().endswith("/>") or tag in ("img", "hr", "br", "meta", "input")
            i += 1
            if not single:
                while i < n:
                    l2 = lines[i].rstrip("\n")
                    block.append(l2); i += 1
                    if l2.startswith("</%s>" % tag):
                        break
            out.append("\n".join(block))
        elif s.startswith("## "):
            out.append(h2(s[3:].strip(), fmt)); i += 1
        elif s.startswith("### "):
            out.append(h3(s[4:].strip(), fmt)); i += 1
        else:  # markdown paragraph (accumulate)
            para_lines = [s]; i += 1
            while i < n:
                l2 = lines[i].rstrip("\n")
                if l2.strip() == "" or l2.startswith("<") or l2.startswith("#"):
                    break
                para_lines.append(l2); i += 1
            out.append(para(" ".join(para_lines), fmt))
    return "\n".join(out)

def build_email(body):
    head = ('<!DOCTYPE html><html lang="en"><head><meta charset="utf-8">'
            '<meta name="viewport" content="width=device-width, initial-scale=1">'
            '<meta name="x-apple-disable-message-reformatting"><style>\n%s%s\n</style>'
            '<title>Jaseci Digest · Issue N.03</title></head>' % (FONT_IMPORT, INTER))
    open_ = ('<body style="margin:0;padding:0;background:#e6e0d4;-webkit-text-size-adjust:100%;'
             "font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">"
             '<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" '
             "style=\"background:#e6e0d4;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">"
             '<tr><td align="center" style="padding:24px 12px;">'
             '<table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" '
             "style=\"width:600px;max-width:600px;background:#ffffff;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">"
             "<tr><td style=\"font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">")
    close = "</td></tr></table></td></tr></table></body></html>"
    return head + open_ + body + close

def build_preview(body):
    head = ('<!DOCTYPE html><html><head><meta charset="utf-8"><style>\n%s%s\n</style>'
            "<style>body{margin:0;background:#cfc8ba;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;}"
            ".wrap{max-width:600px;margin:24px auto;background:#ffffff;padding:0 0 8px;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;}"
            ".wrap h2{font-size:22px;text-transform:uppercase;margin:32px 24px 12px;padding-top:18px;}"
            ".wrap h3{font-size:17px;margin:20px 24px 6px;}.wrap h3 a{color:#160f0a;text-decoration:none;}"
            ".wrap p,.wrap ul{margin:10px 24px;font-size:15px;line-height:1.55;}.wrap a{color:#c0531f;}</style></head>" % (FONT_IMPORT, INTER))
    return head + '<body><div class="wrap">' + body + "</div></body></html>"

def main():
    md = SRC.read_text(encoding="utf-8")
    (HERE / "003-agentic-ai-with-jac.html").write_text(build_email(render_body(md, "email")), encoding="utf-8")
    (HERE / "003-preview.html").write_text(build_preview(render_body(md, "preview")), encoding="utf-8")
    print("regenerated 003-agentic-ai-with-jac.html and 003-preview.html from the .md")

if __name__ == "__main__":
    main()
