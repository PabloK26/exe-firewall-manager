# EXE Firewall Manager

Herramienta Batch para bloquear o desbloquear ejecutables automáticamente en el Firewall de Windows.

## Funciones

- Busca archivos `.exe` en una carpeta
- Crea reglas automáticas
- Elimina reglas existentes
- Reglas de entrada y salida

## Uso

Colocar dirección exacta de la carpeta en donde se encuentran los .exe a bloquear/desbloquear:

```bat
block_exe_firewall.bat "C:\MiPrograma"
```

```bat
unblock_exe_firewall.bat "C:\MiPrograma"
```

## Requisitos

- Windows
- Ejecutar como administrador: Se ejecuta automáticamente como Admin.

## Ejemplo

Si existe:

```text
C:\hola\hola.exe
```

Se crean:

- block_hola_in
- block_hola_out
