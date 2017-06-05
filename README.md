Splitter
========
### Adresářová struktura
```
├── OpenSCAD_STLs                   - Adresář s STL exportovanými z OpenSCADu
│   ├── splitter.stl                - STL z prvního zadání
│   ├── splitter2.stl               - STL z druhého zadání
│   └── splitter_highres.stl        - STL první varianty se zvýšeným $fn
├── Printing                        - Adresář se soubory pro tisk
│   ├── Slic3r_config_bundle.ini    - Konfigurace Slic3ru
│   ├── splitter.gcode              - Vygenerovaný gcode
│   └── splitter.stl                - STL připravené pro slicování
├── README.md
├── splitter.scad       - Hlavní soubor obsahující definice modulu splitter
├── shapes.scad         - Definice tvarů trubek
├── functions.scad      - Pomocné funkce
└── main.scad           - Soubor volající modul splitter se zvolenými daty
```

### Předzpracování
Původně jsem měl v úmyslu vyhnout se podpůrným strukturám, ale přes veškerou snahu se mi nepodařilo rozřezat objekt na rozumný počet částí, které by byly rozumně tisknutelné. Buď části stále vyžadovaly podpory, nebo bylo částí příliš mnoho. Nakonec jsem se tedy uchýlil k vygenerování podpory v Meshmixeru.
