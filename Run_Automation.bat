@echo off
:: Establece la codificación a UTF-8
chcp 65001 >nul

:: Limpiar la pantalla
cls

:: Mensaje de inicio
echo.
echo ============================================
echo   AUTOMATIZACIÓN DE PRUEBAS A SERVICIOS WEB
echo           RESTFUL - BOOKER
echo ============================================
echo.
echo           Realizando pruebas técnicas de YAPE
echo       Automatización creada por Emmanuel Salazar Revoredo
echo.
echo   Iniciando la ejecución de las pruebas...
echo.

:: Animación de puntos suspensivos
setlocal EnableDelayedExpansion
set "dots=..."
set "i=0"

:: Ejecutar Newman y guardar el reporte en la carpeta "newman"
echo Ejecutando las pruebas, espera un momento.
(newman run .\RESTFUL_BOOKER_AUTOMATE.postman_collection.json -r htmlextra) >nul 2>&1 & (

:animate
set /a i+=1
set "char=!dots:~0,%i%!"
if !i! gtr 3 set /a i=0
<nul set /p "=Procesando!char!"
ping -n 1 -w 300 > nul
<nul set /p "=   "
goto animate
)

:: Mostrar alerta indicando que el reporte está listo
echo.
echo ============================================
echo   Pruebas finalizadas. 
echo   Revisa el reporte generado en la carpeta "newman".
echo ============================================

:: Alerta de Windows
msg * "Las pruebas han finalizado. El reporte está disponible en la carpeta 'newman'."

:: Mantener la ventana abierta
pause
