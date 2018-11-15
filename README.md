# Anguiano_Valadez_Tarea_Implementacion_Pipeline

## Actividad a realizar
Implementar un procesador MIPS con pipeline en verilog, tal que pueda ejecutar el siguiente programa:
```
.text
  addi $t0, $zero, 5
  add  $t1, $t0,   $zero
  addi $t1, $t1,   2
  addi $t2, $t1,   3
  addi $t3, $t3,   0x010010000
  sw   $t2, 0($t3)
  
  add  $s0, $t2,   $t1
  sub  $s1, $s0,   $t3
  lw   $t2, 0($t3)
  addi $s2, $s2,   -2
  or   $s2, $s2,   $t4
  sll  $s7, $s2,   2
```

En esta tarea NO se tiene que implementer las unidades de forwarding ni de hazard detection. En el caso que existan hazard de datos o control hay que insertar burbujas. Esta tarea tiene el doble de valor que una tarea habitual.

## Entregables
Un reporte donde se especifique las modificaciones realizadas así como la simulación en modelsim del programa. Esta tarea se revisara en el salón de clases y los archivos se subiran a moodle.

