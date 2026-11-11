#
# --------------------------------------------------------------------------------
# SPDX-FileCopyrightText: 2024-2026 Martin Jan Köhler and Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits.
#
# This file is part of KPEX Documentation
# (see https://github.com/iic-jku/klayout-pex-website).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
# --------------------------------------------------------------------------------
#
from typing import List, Tuple
import drawsvg as dw

INK = '#213547'
SOURCE = '#2364a5'
TARGET = '#13877a'
SHIELD = '#b45a22'
ACCENT = '#8a306f'


def label(drawing: dw.Drawing, text: str, x: float, y: float,
          size: float = 19, color: str = INK, anchor: str = 'start'):
    drawing.append(dw.Text(text, size, x, y, fill=color, font_family='DejaVu Sans',
                           text_anchor=anchor))


def arrow(drawing: dw.Drawing, x0: float, y0: float, x1: float, y1: float,
          color: str = INK, width: float = 1.8, both: bool = False):
    import math
    drawing.append(dw.Line(x0, y0, x1, y1, stroke=color, stroke_width=width))
    angle = math.atan2(y1 - y0, x1 - x0)
    for x, y, direction in ((x1, y1, angle), *(([(x0, y0, angle + math.pi)]) if both else [])):
        left = direction + 2.7
        right = direction - 2.7
        drawing.append(dw.Lines(x + 8 * math.cos(left), y + 8 * math.sin(left), x, y,
                                x + 8 * math.cos(right), y + 8 * math.sin(right),
                                stroke=color, stroke_width=width, fill='none'))


def polygon(drawing: dw.Drawing, points: List[Tuple[float, float]],
            fill: str, stroke: str, opacity: float = 0.2):
    drawing.append(dw.Lines(*(coordinate for point in points for coordinate in point),
                            close=True, fill=fill, fill_opacity=opacity,
                            stroke=stroke, stroke_width=2))
