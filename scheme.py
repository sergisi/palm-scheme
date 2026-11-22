import dataclasses as dto
import os
from jinja2 import Environment, PackageLoader, select_autoescape

env = Environment(loader=PackageLoader("scheme"), autoescape=select_autoescape())

type Color = str


@dto.dataclass
class Scheme:
    primary: Color
    secondary: Color
    ternary: Color
    red: Color
    text: Color
    subtext0: Color
    subtext1: Color
    surface1: Color
    surface0: Color
    crust: Color


def transform_template(temp: str, scheme: Scheme):
    template = env.get_template(temp)
    return template.render(**dto.asdict(scheme))


schemes: dict[str, Scheme] = {
    "gruvbox-light": Scheme(
        "d65d0e",
        "b16286",
        "689d6a",
        "cc241d",
        "282828",
        "3c3836",
        "504945",
        "a89984",
        "ebdbb2",
        "fbf1c7",
    ),
    "gruvbox-dark": Scheme(
        "d65d0e",
        "689d6a",
        "b16286",
        "cc241d",
        "ebdbb2",
        "d5c4a1",
        "bdae93",
        "3c3836",
        "282828",
        "1d2021",
    ),
    "mocha": Scheme(
        "fab387",
        "89b4fa",
        "f2cdcd",
        "f38ba8",
        "cdd6f4",
        "bac2de",
        "a6adc8",
        "45475a",
        "313244",
        "11111b",
    ),
    "frappe": Scheme(
        "ef9f76",
        "8caaee",
        "eebebe",
        "e78284",
        "c6d0f5",
        "b5bfe2",
        "a5adce",
        "51576d",
        "414559",
        "232634",
    ),
    "macchiato": Scheme(
        "f5a97f",
        "8aadf4",
        "f0c6c6",
        "ed8796",
        "cad3f5",
        "b8c0e0",
        "a5adcb",
        "494d64",
        "363a4f",
        "181926",
    ),
    "latte": Scheme(
        "fe640b",
        "1e66f5",
        "dd7878",
        "d20f39",
        "4c4f69",
        "5c5f77",
        "6c6f85",
        "bcc0cc",
        "ccd0da",
        "dce0e8",
    ),
}

for name in schemes:
    for fil in os.listdir('./templates/'):
        savename = fil[:-len('.template')]
        print(f'Saving to { savename }')
        with open(f'{name}/{savename}', 'w') as f:
            print(transform_template(fil, schemes[name]), file=f)
        
